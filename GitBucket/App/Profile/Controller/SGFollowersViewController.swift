//
//  SGFollowersViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGFollowersViewController: SGUserListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = self.user {
            if user.login == AppData.default.user?.login {
                title = "我的粉丝"
            }
            else {
                title = "他/她的粉丝"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping SGUserListViewController.FetchUsersCompletionBlock) {
        SGGithubClient.fetchFollowersForUser(user!, page: nextPage!, completion: completion)
    }
}
