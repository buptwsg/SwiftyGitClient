//
//  SGPopularUsersViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGPopularUsersViewController: SGUserListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "All Countries\nAll Languages"
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping ([SGUser]?, Int?, Error?) -> Void) {
        SGGithubClient.fetchPopularUsers(location: "", language: "") { (users, error) in
            completion(users, nil, error)
        }
    }
    
    @objc
    func tapSettingButton() {
        let countryAndLanguagePicker = SGCountryAndLanguagePicker()
        navigationController?.pushViewController(countryAndLanguagePicker, animated: true)
    }
}
