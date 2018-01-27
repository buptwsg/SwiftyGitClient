//
//  WXMiddleButtonTabBarController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/23.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class WXMiddleButtonTabBarController: UITabBarController {
    
    //MARK: Properties
    var middleButtonTabBar: WXMiddleButtonTabBar {
        return self.tabBar as! WXMiddleButtonTabBar
    }
    
    //MARK: Public
    func addChildViewController(_ childViewController: UIViewController, title: String, image imageName: String, selectedImage selectedImageName: String? = nil) {
        let navVC = WXNavigationController(rootViewController: childViewController)
        childViewController.navigationItem.title = title
        childViewController.tabBarItem.title = title
        
        if var normalImage = UIImage(named: imageName) {
            normalImage = normalImage.withRenderingMode(.alwaysOriginal)
            childViewController.tabBarItem.image = normalImage
        }
        
        if let _ = selectedImageName {
            if var selectedImage = UIImage(named: selectedImageName!) {
                selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
                childViewController.tabBarItem.selectedImage = selectedImage
            }
        }
        
        self.addChildViewController(navVC)
    }
    
    func addChildViewController(_ childViewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage? = nil) {
        let navVC = WXNavigationController(rootViewController: childViewController)
        childViewController.navigationItem.title = title
        childViewController.tabBarItem.title = title
        childViewController.tabBarItem.image = image;
        if let _ = selectedImage {
            childViewController.tabBarItem.selectedImage = selectedImage
        }
        
        self.addChildViewController(navVC)
    }
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTabBar = WXMiddleButtonTabBar(frame: .zero)
        self.setValue(myTabBar, forKey: "tabBar")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
