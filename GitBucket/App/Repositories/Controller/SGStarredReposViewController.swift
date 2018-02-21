//
//  SGStarredReposViewController.swift
//  GitBucket
//
//  Created by shuguang on 2018/2/16.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGStarredReposViewController: SGRepoListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var viewTitle: String {
        return "Starred Repos"
    }
    
    override func executeRequestWithCompletionBlock(completion: @escaping FetchReposCompletionBlock) {
        //判断是自己还是别人，调用不同的接口
    }
}
