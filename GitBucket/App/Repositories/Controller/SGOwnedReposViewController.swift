//
//  SGOwnedReposViewController.swift
//  GitBucket
//
//  Created by shuguang on 2018/2/16.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGOwnedReposViewController: SGRepoListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var viewTitle: String {
        return "Public Repos"
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping FetchReposCompletionBlock) {
        if AppData.default.isLoggedUser(self.entity!) {
            SGGithubClient.fetchRepositories(page: nextPage!, completion: completion)
        }
        else {
            SGGithubClient.fetchRepositories(login: self.entity?.login, page: nextPage!, completion: completion)
        }
    }
}
