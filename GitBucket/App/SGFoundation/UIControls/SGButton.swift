//
//  SGButton.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/30.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGButton: UIButton {
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func titleColor(for state: UIControlState) -> UIColor? {
        switch state {
        case UIControlState.normal, UIControlState.highlighted, UIControlState.selected, UIControlState.application, UIControlState.reserved, UIControlState.focused:
            return UIColor.white
            
        case UIControlState.disabled:
            return UIColor.colorFromHex(hex: 0xCFCFCF)
            
        default:
            return UIColor.white
        }
    }
    
    override func backgroundImage(for state: UIControlState) -> UIImage? {
        switch state {
        case UIControlState.normal:
            return UIImage.image(from: 0x576871)
            
        case UIControlState.highlighted, UIControlState.selected, UIControlState.application, UIControlState.reserved, UIControlState.focused:
            return UIImage.image(from: 0x41525B)
            
        case UIControlState.disabled:
            return UIImage.image(from: 0x6D7E87)
            
        default:
            return UIImage()
        }
    }
    
    private func initialize() {
        layer.cornerRadius = 3
        layer.masksToBounds = true
        
        setBackgroundImage(backgroundImage(for: UIControlState.normal), for: UIControlState.normal)
        setBackgroundImage(backgroundImage(for: UIControlState.disabled), for: UIControlState.disabled)
        setBackgroundImage(backgroundImage(for: UIControlState.highlighted), for: UIControlState.highlighted)
        
        setTitleColor(titleColor(for: UIControlState.normal), for: UIControlState.normal)
        setTitleColor(titleColor(for: UIControlState.disabled), for: UIControlState.disabled)
        setTitleColor(titleColor(for: UIControlState.highlighted), for: UIControlState.highlighted)
    }
}
