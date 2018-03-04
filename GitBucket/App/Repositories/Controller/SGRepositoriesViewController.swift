//
//  SGRepositoriesViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/4.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGRepositoriesViewController: SGSegmentedControlViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UI
    func setupUI() {
        let ownedReposVC = SGAllReposViewController.allReposViewController(category: .owned)
        ownedReposVC.segmentedTitle = "Owned"
        let starredReposVC = SGAllReposViewController.allReposViewController(category: .starred)
        starredReposVC.segmentedTitle = "Starred"
        
        self.viewControllers = [ownedReposVC, starredReposVC]
    }
}
