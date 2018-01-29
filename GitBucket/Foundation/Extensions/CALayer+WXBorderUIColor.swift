//
//  CALayer+WXBorderUIColor.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

extension CALayer {
    var borderUIColor: UIColor {
        get {
            guard let cgColor = self.borderColor else {
                return UIColor.clear
            }
            
            return UIColor(cgColor: cgColor)
        }
        
        set {
            self.borderColor = newValue.cgColor
        }
    }
}
