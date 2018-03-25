//
//  UIView+Find.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/25.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

extension UIView {
    func wx_subviewPassingTest(_ predicate: (_ view: UIView) -> Bool) -> UIView? {
        var result: UIView? = nil
        for subview in self.subviews {
            if predicate(subview) {
                result = subview
                break
            }
            
            result = subview.wx_subviewPassingTest(predicate)
            
            if nil != result {
                break
            }
        }
        
        return result
    }
}
