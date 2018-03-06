//
//  UIViewController+ContentInset.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/6.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

extension UIViewController {
    var contentInset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        }
        else {
            let topInset = topLayoutGuide.length
            let bottomInset = bottomLayoutGuide.length
            let contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0)
            return contentInset
        }
    }
}
