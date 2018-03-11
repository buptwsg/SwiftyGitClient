//
//  SGFollowingsViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGFollowingsViewController: SGUserListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = self.user {
            if user.login == AppData.default.user?.login {
                title = "我的关注"
            }
            else {
                title = "他/她的关注"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping ([SGUser]?, Int?, Error?) -> Void) {
        SGGithubClient.fetchFollowingsForUser(user!, page: nextPage!, completion: completion)
    }
}
