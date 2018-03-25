//
//  SGSearchReposResultViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/25.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGSearchReposResultViewController: SGRepoListViewController {
    var keyword: String = ""
    var language: String = ""
    override var fetchAtViewDidLoad: Bool {return false}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping SGRepoListViewController.FetchReposCompletionBlock) {
        SGGithubClient.searchRepos(query: keyword, language: language, ascending: false, page: nextPage) { (repos, nextPage, error) in
            completion(repos, nextPage, error)
        }
    }
}
