//
//  UIView+WXHelper.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

extension UIView {
    class func instantiateFromNib() -> UIView? {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: NSStringFromClass(self), bundle: bundle)
        if let views = nib.instantiate(withOwner: nil, options: nil) as? [UIView] {
            for view in views {
                if view.isKind(of: self) {
                    return view
                }
            }
        }
        
        return nil
    }
    
    var left: CGFloat {
        get {
            return self.frame.minX
        }
        set {
            var oldFrame = self.frame
            oldFrame.origin.x = newValue
            self.frame = oldFrame
        }
    }
    
    var top: CGFloat {
        get {
            return self.frame.minY
        }
        
        set {
            var oldFrame = self.frame
            oldFrame.origin.y = newValue
            self.frame = oldFrame
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.maxX
        }
        
        set {
            var oldFrame = self.frame
            oldFrame.origin.x = newValue - self.frame.width
            self.frame = oldFrame
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.maxY
        }
        
        set {
            var oldFrame = self.frame
            oldFrame.origin.y = newValue - oldFrame.height
            self.frame = oldFrame
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.width
        }
        
        set (newWidth) {
            var oldFrame = self.frame
            oldFrame.size.width = newWidth
            self.frame = oldFrame
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.height
        }
        
        set (newHeight) {
            var oldFrame = self.frame
            oldFrame.size.height = newHeight
            self.frame = oldFrame
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.frame.midX
        }
        
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.frame.midY
        }
        
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            var oldFrame = self.frame
            oldFrame.origin = newValue
            self.frame = oldFrame
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var oldFrame = self.frame
            oldFrame.size = newValue
            self.frame = oldFrame
        }
    }
    
    var isPortrait: Bool {
        guard let window = self.window else {
            return true
        }
        
        let windowSize = window.size
        return windowSize.width < windowSize.height
    }
    
    var viewController: UIViewController? {
        get {
            var view: UIView? = self
            while view != nil {
                if let responder = view?.next, responder is UIViewController {
                    return responder as? UIViewController
                }
                
                view = view?.superview
            }
            
            return nil
        }
    }
}
