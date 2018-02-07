//
//  SGRootTabBarViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/26.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import OcticonsKit

class SGRootTabBarViewController: WXMiddleButtonTabBarController, WXMiddleButtonTabBarDelegate {
    static var instance: SGRootTabBarViewController  {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateInitialViewController() as! SGRootTabBarViewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        WXMiddleButtonTabBar.normalTextColor = UIColor.gray
        WXMiddleButtonTabBar.selectedTextColor = UIColor.darkGray
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
        var normalImage = UIImage.octicon(with: .rss, textColor: UIColor.lightGray, size: iconSize)
        var selectedImage = UIImage.octicon(with: .rss, textColor: SGAppColors.colorI3.color, size: iconSize).withRenderingMode(.alwaysOriginal)
        self.addChildViewController(vc1, title: "Events", image: normalImage, selectedImage: selectedImage)
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.green
        normalImage = UIImage.octicon(with: .repo, textColor: UIColor.lightGray, size: iconSize)
        selectedImage = UIImage.octicon(with: .repo, textColor: SGAppColors.colorI3.color, size: iconSize).withRenderingMode(.alwaysOriginal)
        self.addChildViewController(vc2, title: "Repositories", image: normalImage, selectedImage: selectedImage)
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.blue
        normalImage = UIImage.octicon(with: .search, textColor: UIColor.lightGray, size: iconSize)
        selectedImage = UIImage.octicon(with: .search, textColor: SGAppColors.colorI3.color, size: iconSize).withRenderingMode(.alwaysOriginal)
        self.addChildViewController(vc3, title: "Search", image: normalImage, selectedImage: selectedImage)
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.orange
        normalImage = UIImage.octicon(with: .person, textColor: UIColor.lightGray, size: iconSize)
        selectedImage = UIImage.octicon(with: .person, textColor: SGAppColors.colorI3.color, size: iconSize).withRenderingMode(.alwaysOriginal)
        self.addChildViewController(vc4, title: "Profile", image: normalImage, selectedImage: selectedImage)
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
