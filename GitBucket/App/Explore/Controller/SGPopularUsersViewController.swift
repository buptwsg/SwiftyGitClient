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

        title = "All Countries\nAll Languages"
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
}
