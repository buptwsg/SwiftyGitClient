//
//  UIImage+Extensions.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/30.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

extension UIImage {
    public class func image(from colorHex: Int) -> UIImage {
        let color = UIColor.colorFromHex(hex: colorHex)
        return color.toImage()!
    }
}
