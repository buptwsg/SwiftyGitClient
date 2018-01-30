//
//  UIColorExtension.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/1/27.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

public extension UIColor {
    public class func colorFromHex(hex: Int) -> UIColor {
        return colorFromHex(hex: hex, alpha: 1)
    }
    
    public class func colorFromHex(hex: Int, alpha: CGFloat) -> UIColor {
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = hex & 0x0000ff
        return UIColor(red: 1.0 * CGFloat(r) / 255.0, green: 1.0 * CGFloat(g) / 255.0, blue: 1.0 * CGFloat(b) / 255.0, alpha: alpha)
    }
    
    func toImage(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
