//
//  SGTrendingReposViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/22.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGTrendingReposViewController: SGBaseViewController, SGPickerDelegate {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var separator: UIView?
    let margin: CGFloat = 8
    var language: String? {
        return AppData.default.languageDataOfTrendingRepos?.name
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = language
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = SGAppColors.colorI3.color
        segmentedControl.addTarget(self, action: #selector(segmentedControlIndexChanged(_:)), for: .valueChanged)
        
        separator = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 1.0 / UIScreen.main.scale))
        separator?.autoresizingMask = .flexibleWidth
        separator?.backgroundColor = SGAppColors.colorB2.color
        view.addSubview(separator!)
        
        let normalImage = UIImage.icon(with: "Gear", color: UIColor.lightGray, size: CGSize(width: 22, height: 22))
        let settingButton = createCustomBarButton(normalImage: normalImage, selector: #selector(tapSettingButton))
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = -16
        navigationItem.rightBarButtonItems = [fixedSpace, settingButton]
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if searchQueryChanged {
            searchQueryChanged = false
            title = language
            
            currentViewController?.refreshRepositories()
            
            for childVC in viewControllers {
                if childVC !== currentViewController {
                    childVC.needsRefresh = true
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        segmentedControl.top = self.contentInset.top + margin
        separator?.top = segmentedControl.bottom + margin - separator!.height
        
        setupChildViewControllers()
    }
    
    //MARK: - Child View Controllers
    private var currentViewController: SGTimedTrendingsViewController?
    private var viewControllers: [SGTimedTrendingsViewController] = []
    private var childVCViewFrame: CGRect {
        let top = segmentedControl.bottom + margin
        return CGRect(x: 0, y: top, width: view.width, height: view.height - top)
    }
    
    private func setupChildViewControllers() {
        if !viewControllers.isEmpty {return}
        
        let dailyTrendings = SGRepoListViewController.createInstance(for: nil, category: .trending, supportPullUpRefresh: false) as! SGTimedTrendingsViewController
        dailyTrendings.timeSlug = "daily"
        let weeklyTrendings = SGRepoListViewController.createInstance(for: nil, category: .trending, supportPullUpRefresh: false) as! SGTimedTrendingsViewController
        weeklyTrendings.timeSlug = "weekly"
        let monthlyTrendings = SGRepoListViewController.createInstance(for: nil, category: .trending, supportPullUpRefresh: false) as! SGTimedTrendingsViewController
        monthlyTrendings.timeSlug = "monthly"
        
        viewControllers = [dailyTrendings, weeklyTrendings, monthlyTrendings]
        let currentVC = dailyTrendings
        addChildViewController(currentVC)
        view.addSubview(currentVC.view)
        currentVC.view.frame = childVCViewFrame
        currentVC.didMove(toParentViewController: self)
        currentViewController = dailyTrendings
    }
    
    @objc
    func segmentedControlIndexChanged(_ segmentedControl: UISegmentedControl) {
        if let currentViewController = self.currentViewController {
            let toViewController = viewControllers[segmentedControl.selectedSegmentIndex]
            cycle(fromViewController: currentViewController, toViewController: toViewController)
        }
    }
    
    func cycle(fromViewController: SGTimedTrendingsViewController, toViewController: SGTimedTrendingsViewController) {
        fromViewController.willMove(toParentViewController: nil)
        addChildViewController(toViewController)
        toViewController.view.frame = childVCViewFrame
        
        transition(from: fromViewController, to: toViewController, duration: 0, options: [], animations: nil) { finished in
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
            
            self.currentViewController = toViewController
        }
    }
    
    //MARK: - Change Language Setting
    private var searchQueryChanged = false
    
    @objc
    func tapSettingButton() {
        let languagePicker = SGPickerViewController()
        languagePicker.segmentedTitle = "Language"
        languagePicker.resource = "Languages"
        languagePicker.delegate = self
        languagePicker.selectedData = AppData.default.languageDataOfTrendingRepos
        languagePicker.manualAdjustInset = false
        
        navigationController?.pushViewController(languagePicker, animated: true)
    }
    
    func picker(_ picker: SGPickerViewController, didPickExploreData data: SGExploreData) {
        if data != AppData.default.languageDataOfTrendingRepos {
            AppData.default.languageDataOfTrendingRepos = data
            AppData.default.save()
            searchQueryChanged = true
        }
    }
}
