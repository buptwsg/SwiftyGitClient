//
//  SGTrendingReposViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/22.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGTrendingReposViewController: SGBaseViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var separator: UIView?
    let margin: CGFloat = 8
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = AppData.default.languageDataOfTrendingRepos?.name
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = SGAppColors.colorI3.color
        segmentedControl.addTarget(self, action: #selector(segmentedControlIndexChanged(_:)), for: .valueChanged)
        
        separator = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 1.0 / UIScreen.main.scale))
        separator?.autoresizingMask = .flexibleWidth
        separator?.backgroundColor = SGAppColors.colorB2.color
        view.addSubview(separator!)
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
    private var currentViewController: UIViewController?
    private var viewControllers: [UIViewController] = []
    
    private func setupChildViewControllers() {
        if viewControllers.isEmpty {return}
        
        let dailyTrendings = SGRepoListViewController.createInstance(for: nil, category: .trending, supportPullUpRefresh: false)
        let weeklyTrendings = SGRepoListViewController.createInstance(for: nil, category: .trending, supportPullUpRefresh: false)
        let monthlyTrendings = SGRepoListViewController.createInstance(for: nil, category: .trending, supportPullUpRefresh: false)
        
        viewControllers = [dailyTrendings, weeklyTrendings, monthlyTrendings]
        let currentVC = dailyTrendings
        addChildViewController(currentVC)
        view.addSubview(currentVC.view)
        currentVC.view.frame = CGRect.zero
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
    
    func cycle(fromViewController: UIViewController, toViewController: UIViewController) {
        fromViewController.willMove(toParentViewController: nil)
        addChildViewController(toViewController)
        toViewController.view.frame = self.view.bounds
        
        transition(from: fromViewController, to: toViewController, duration: 0, options: [], animations: nil) { finished in
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
            
            self.currentViewController = toViewController
        }
    }
}
