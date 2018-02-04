//
//  WXNavigationBar.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/2/4.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

public class WXNavigationBar: UINavigationBar {
    public static let borderMarginForBarItem: CGFloat = 8
    
    public override func layoutSubviews() {
        if #available(iOS 11.0, *) {
            let margin = type(of: self).borderMarginForBarItem
            
            for view in subviews {
                for stackView in view.subviews {
                    if stackView is UIStackView {
                        stackView.superview?.layoutMargins = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
                    }
                }
            }
        }
        else {
            super.layoutSubviews()
        }
    }
}
