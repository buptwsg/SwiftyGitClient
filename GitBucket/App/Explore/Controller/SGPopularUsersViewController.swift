//
//  SGPopularUsersViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGPopularUsersViewController: SGUserListViewController {
    var country: String {
        return AppData.default.countryDataOfPopularUsers!.name
    }
    
    var countrySlug: String {
        return AppData.default.countryDataOfPopularUsers!.slug
    }
    
    var language: String {
        return AppData.default.languageDataOfPopularUsers!.name
    }
    
    var languageSlug: String {
        return AppData.default.languageDataOfPopularUsers!.slug
    }
    
    var titleText: String {
        return "\(country)\n\(language)"
    }
    
    private var searchQueryChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let label = UILabel()
        label.numberOfLines = 0
        label.text = titleText
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.sizeToFit()
        navigationItem.titleView = label
        
        let normalImage = UIImage.icon(with: "Gear", color: UIColor.lightGray, size: CGSize(width: 22, height: 22))
        let settingButton = createCustomBarButton(normalImage: normalImage, selector: #selector(tapSettingButton))
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = -16
        navigationItem.rightBarButtonItems = [fixedSpace, settingButton]
    }

    override func viewDidAppear(_ animated: Bool) {
        if searchQueryChanged {
            searchQueryChanged = false
            if let label = navigationItem.titleView as? UILabel {
                label.text = titleText
                label.sizeToFit()
            }
            tableView.mj_header.beginRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping ([SGUser]?, Int?, Error?) -> Void) {
        SGGithubClient.fetchPopularUsers(location: countrySlug, language: languageSlug) { (users, error) in
            completion(users, nil, error)
        }
    }
    
    @objc
    func tapSettingButton() {
        let countryAndLanguagePicker = SGCountryAndLanguagePicker()
        countryAndLanguagePicker.notifyChangeBlock = {
            self.searchQueryChanged = true
        }
        navigationController?.pushViewController(countryAndLanguagePicker, animated: true)
    }
}
