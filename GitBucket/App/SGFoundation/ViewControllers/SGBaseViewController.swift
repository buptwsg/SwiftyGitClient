//
//  SGBaseViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/30.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import Toast_Swift

class SGBaseViewController: UIViewController {
    deinit {
        showDeinitToast()
    }
}

extension UIViewController {
    func showDeinitToast() {
        guard let keyWindow = self.view.window else {
            return
        }
        
        var message: String? = nil
        if let title = self.title {
            message = "\(title)已释放"
        }
        else {
            let classString = NSStringFromClass(type(of: self))
            message = "\(classString)已释放"
        }
        
        keyWindow.makeToast(message, duration: ToastManager.shared.duration, position: .center)
    }
}
