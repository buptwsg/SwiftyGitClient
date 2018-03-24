//
//  SGTimedTrendingsViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/22.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGTimedTrendingsViewController: SGRepoListViewController {
    var needsRefresh: Bool = false
    var timeSlug: String = ""
    var language: String {
        return AppData.default.languageDataOfTrendingRepos!.slug
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if needsRefresh {
            needsRefresh = false
            refreshRepositories()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping SGRepoListViewController.FetchReposCompletionBlock) {
        SGGithubClient.fetchTrendingRepos(since: timeSlug, language: language) { (repos, error) in
            completion(repos, nil, error)
        }
    }
}
