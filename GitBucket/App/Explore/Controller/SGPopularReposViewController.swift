//
//  SGPopularReposViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/22.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGPopularReposViewController: SGRepoListViewController, SGPickerDelegate {
    var language: String {
        return AppData.default.languageDataOfPopularRepos!.name
    }
    
    var languageSlug: String {
        return AppData.default.languageDataOfPopularRepos!.slug
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
            tableView.mj_header.beginRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Override
    override var viewTitle: String {
        return language
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping SGRepoListViewController.FetchReposCompletionBlock) {
        SGGithubClient.fetchPopularRepos(language: languageSlug) { (repos, nextPage, error) in
            completion(repos, nextPage, error)
        }
    }
    
    //MARK: - Actions
    private var searchQueryChanged = false
    
    @objc
    func tapSettingButton() {
        let languagePicker = SGPickerViewController()
        languagePicker.segmentedTitle = "Language"
        languagePicker.resource = "Languages"
        languagePicker.delegate = self
        languagePicker.selectedData = AppData.default.languageDataOfPopularRepos
        languagePicker.manualAdjustInset = false
        
        navigationController?.pushViewController(languagePicker, animated: true)
    }
    
    //MARK: - SGPickerDelegate
    func picker(_ picker: SGPickerViewController, didPickExploreData data: SGExploreData) {
        if data != AppData.default.languageDataOfPopularRepos {
            AppData.default.languageDataOfPopularRepos = data
            AppData.default.save()
            searchQueryChanged = true
        }
    }
}
