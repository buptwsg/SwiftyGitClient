//
//  WXNavigationController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/23.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class WXNavigationController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let _ = self.topViewController {
            viewController.hidesBottomBarWhenPushed = true;
        }
        
        super.pushViewController(viewController, animated: animated)
        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myNavigationBar = WXNavigationBar(frame: .zero)
        setValue(myNavigationBar, forKey: "navigationBar")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
