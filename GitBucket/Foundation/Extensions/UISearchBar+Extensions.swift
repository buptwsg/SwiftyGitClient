//
//  UISearchBar+Extensions.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/25.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

extension UISearchBar {
    var searchIconView: UIImageView {
        return wx_subviewPassingTest({ (subview) -> Bool in
            let classString = String(describing: type(of: subview.superview!))
            if subview.isMember(of: UIImageView.self) && classString.hasSuffix("TextField") {
                return true
            }
            
            return false
        }) as! UIImageView
    }
}
