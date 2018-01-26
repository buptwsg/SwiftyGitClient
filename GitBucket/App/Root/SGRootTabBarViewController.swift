//
//  SGRootTabBarViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/26.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGRootTabBarViewController: WXMiddleButtonTabBarController, WXMiddleButtonTabBarDelegate {
    init() {
        WXMiddleButtonTabBar.normalTextColor = UIColor.gray
        WXMiddleButtonTabBar.selectedTextColor = UIColor.darkGray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.middleButtonTabBar.wxDelegate = self
        //set middle button
        //add four child view controllers, then test
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: WXMiddleButtonTabBarDelegate
    func tabBarMiddleButtonDidSelected(_ tabBar: WXMiddleButtonTabBar) {
    }
    
    func tabBarMiddleButtonDidLongPressed(_ tabBar: WXMiddleButtonTabBar) {
        
    }
}
