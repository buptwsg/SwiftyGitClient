//
//  SGFontIcon.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/9.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import OcticonsIOS

extension UIImage {
    class func icon(with name: String, color: UIColor, size: CGSize) -> UIImage {
        return UIImage.octicon_image(withIcon: name, backgroundColor: UIColor.clear, iconColor: color, iconScale: 1, andSize: size)
    }
}
