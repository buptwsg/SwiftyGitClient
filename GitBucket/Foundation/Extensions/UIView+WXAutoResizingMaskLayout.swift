//
//  UIView+WXAutoResizingMaskLayout.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

typealias WXUIViewSnapBorderBlock = (_ margin: CGFloat) -> UIView
typealias WXUIViewFlexibleWHBlock = (_ margin1: CGFloat, _ margin2: CGFloat) -> UIView
typealias WXUIViewFillWithEdgesBlock = (_ insets: UIEdgeInsets) -> Void

extension UIView {
    var snapLeft: WXUIViewSnapBorderBlock {
        func block(border: CGFloat) -> UIView {
            self.left = border
            self.autoresizingMask.insert(.flexibleRightMargin)
            return self
        }
        
        return block
    }
    
    var snapTop: WXUIViewSnapBorderBlock {
        func block(border: CGFloat) -> UIView {
            self.top = border
            self.autoresizingMask.insert(.flexibleBottomMargin)
            return self
        }
        
        return block
    }
    
    var snapRight: WXUIViewSnapBorderBlock {
        func block(border: CGFloat) -> UIView {
            self.right = self.superview!.width - border
            self.autoresizingMask.insert(.flexibleLeftMargin)
            return self
        }
        
        return block
    }
    
    var snapBottom: WXUIViewSnapBorderBlock {
        func block(border: CGFloat) -> UIView {
            self.bottom = self.superview!.height - border
            self.autoresizingMask.insert(.flexibleTopMargin)
            return self
        }
        return block
    }
    
    var snapHCenter: UIView {
        self.centerX = self.superview!.width / 2
        self.autoresizingMask.insert(.flexibleLeftMargin)
        self.autoresizingMask.insert(.flexibleRightMargin)
        return self
    }
    
    var snapVCenter: UIView {
        self.centerY = self.superview!.height / 2
        self.autoresizingMask.insert(.flexibleTopMargin)
        self.autoresizingMask.insert(.flexibleBottomMargin)
        return self
    }
    
    var flexibleWidth: WXUIViewFlexibleWHBlock {
        func block(margin1: CGFloat, margin2: CGFloat) -> UIView {
            let frame = self.frame
            self.frame = CGRect(x: margin1, y: frame.origin.y, width: self.superview!.width - margin1 - margin2, height: frame.size.height)
            self.autoresizingMask.insert(.flexibleWidth)
            return self
        }
        
        return block
    }
    
    var flexibleHeight: WXUIViewFlexibleWHBlock {
        func block(margin1: CGFloat, margin2: CGFloat) -> UIView {
            let frame = self.frame
            self.frame = CGRect(x: frame.origin.x, y: margin1, width: frame.size.width, height: superview!.height - margin1 - margin2)
            self.autoresizingMask.insert(.flexibleHeight)
            return self
        }
        
        return block
    }
    
    var fillSuperViewWithEdges: WXUIViewFillWithEdgesBlock {
        func block(insets: UIEdgeInsets) -> Void {
            self.frame = CGRect(x: insets.left, y: insets.top, width: superview!.width - insets.left - insets.right, height: superview!.height - insets.top - insets.bottom)
            self.autoresizingMask.insert(.flexibleWidth)
            self.autoresizingMask.insert(.flexibleHeight)
        }
        
        return block
    }
    
    func fillSuperView() {
        self.fillSuperViewWithEdges(.zero)
    }
    
    var and: UIView {
        return self
    }
}
