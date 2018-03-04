//
//  SGRootTabBarViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/26.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGRootTabBarViewController: WXMiddleButtonTabBarController, WXMiddleButtonTabBarDelegate {
    static var instance: SGRootTabBarViewController  {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateInitialViewController() as! SGRootTabBarViewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.middleButtonTabBar.wxDelegate = self
        
        //set middle button
        let middleButton = UIButton(type: .custom)
        middleButton.setImage(UIImage(named: "post_normal"), for: .normal)
        self.middleButtonTabBar.setMiddleButton(middleButton, atCenterY: self.middleButtonTabBar.frame.size.height / 2 - 10)
        
        //add four child view controllers
        let iconSize = CGSize(width: 25, height: 25)
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.red
        var normalImage = UIImage.icon(with: "Rss", color: UIColor.lightGray, size: iconSize)
        self.addChildViewController(vc1, title: "Events", image: normalImage)
        
        let reposVC = SGRepositoriesViewController()
        normalImage = UIImage.icon(with: "Repo", color: UIColor.lightGray, size: iconSize)
        self.addChildViewController(reposVC, title: "Repositories", image: normalImage)
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.blue
        normalImage = UIImage.icon(with: "Search", color: UIColor.lightGray, size: iconSize)
        self.addChildViewController(vc3, title: "Search", image: normalImage)
        
        let profileVC = SGSelfProfileViewController(nibName: "SGBaseProfileViewController", bundle: nil)
        normalImage = UIImage.icon(with: "Person", color: UIColor.lightGray, size: iconSize)
        self.addChildViewController(profileVC, title: "Profile", image: normalImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - WXMiddleButtonTabBarDelegate
    func tabBarMiddleButtonDidSelected(_ tabBar: WXMiddleButtonTabBar) {
    }
}
