//
//  WXMiddleButtonTabBar.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/23.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

protocol WXMiddleButtonTabBarDelegate: NSObjectProtocol {
    func tabBarMiddleButtonDidSelected(_ tabBar: WXMiddleButtonTabBar)
    func tabBarMiddleButtonDidLongPressed(_ tabBar: WXMiddleButtonTabBar)
}

class WXMiddleButtonTabBar: UITabBar {
    //MARK: Properties
    static var normalTextColor: UIColor?
    static var selectedTextColor: UIColor?
    
    weak var wxDelegate: WXMiddleButtonTabBarDelegate?
    
    var imageViewsArray: [UIImageView] {
        return internalImageViewsArray
    }
    
    var labelsArray: [UILabel] {
        return internalLabelsArray
    }
    
    //MARK: Public Methods
    func setMiddleButton(_ button: UIButton, atCenterY centerY: CGFloat) {
        self.middleButton = button
        self.middleButtonCenterY = centerY
        button.sizeToFit()
        self.addSubview(button)
        
        button.addTarget(self, action: #selector(middleButtonClicked), for: .touchUpInside)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(middleButtonLongPressed(_:)))
        button.addGestureRecognizer(longPress)
    }
    
    //MARK: Overrides
    override init(frame: CGRect) {
        middleButtonCenterY = 0
        internalImageViewsArray = []
        internalLabelsArray = []
        super.init(frame: frame)
        self.customizeAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        middleButtonCenterY = 0
        internalImageViewsArray = []
        internalLabelsArray = []
        super.init(coder: aDecoder)
        self.customizeAppearance()
    }
    
    override func didAddSubview(_ subview: UIView) {
        if let buttonClass = NSClassFromString("UITabBarButton") {
            if subview.isKind(of: buttonClass) {
                for view in subview.subviews {
                    if view is UIImageView {
                        self.internalImageViewsArray.append(view as! UIImageView)
                    }
                    else if view is UILabel {
                        self.internalLabelsArray.append(view as! UILabel)
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.middleButton?.center = CGPoint(x: self.frame.size.width / 2, y: self.middleButtonCenterY)
        
        var buttonsArray = [UIView]()
        if let buttonClass = NSClassFromString("UITabBarButton") {
            for view in self.subviews {
                if view.isKind(of: buttonClass) {
                    buttonsArray.append(view)
                }
            }
        }
        
        var btnIndex = 0
        let buttonWidth: CGFloat = self.frame.size.width / CGFloat(buttonsArray.count + 1)
        for button in buttonsArray {
            button.frame = CGRect(x: buttonWidth * CGFloat(btnIndex), y: button.frame.origin.y, width: buttonWidth, height: button.frame.size.height)
            btnIndex += 1
            
            if btnIndex == buttonsArray.count / 2 {
                btnIndex += 1
            }
        }
        
        if let _ = self.middleButton {
            self.bringSubview(toFront: self.middleButton!)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let _ = self.middleButton else {
            return super.hitTest(point, with: event)
        }
        
        if !self.isHidden {
            let newPoint = self.convert(point, to: self.middleButton)
            if self.middleButton!.point(inside: newPoint, with: event) {
                return self.middleButton
            }
            else {
                return super.hitTest(point, with: event)
            }
        }
        else {
            return super.hitTest(point, with: event)
        }
    }
    
    //MARK: Private
    fileprivate var middleButton: UIButton?
    fileprivate var middleButtonCenterY: CGFloat
    fileprivate var internalImageViewsArray: [UIImageView]
    fileprivate var internalLabelsArray: [UILabel]
    
    func customizeAppearance() {
        let tabBarItem = UITabBarItem.appearance(whenContainedInInstancesOf: [type(of: self)])
        
        if let normalColor = WXMiddleButtonTabBar.normalTextColor {
            let normalAttributes = [NSAttributedStringKey.foregroundColor: normalColor]
            tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        }
        
        if let selectedColor = WXMiddleButtonTabBar.selectedTextColor {
            let selectedAttributes = [NSAttributedStringKey.foregroundColor: selectedColor]
            tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        }
    }
    
    @objc
    func middleButtonClicked() {
        if let _ = self.wxDelegate {
            self.wxDelegate?.tabBarMiddleButtonDidSelected(self)
        }
    }
    
    @objc
    func middleButtonLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            if let _ = self.wxDelegate {
                self.wxDelegate?.tabBarMiddleButtonDidLongPressed(self)
            }
        }
    }
}
