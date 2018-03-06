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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton()
    }
}

extension UIViewController {
    func showDeinitToast() {
        guard let keyWindow = UIApplication.shared.keyWindow else {
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
        
        keyWindow.showToast(message!)
    }
    
    @objc
    func tapBackButton(_ button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupBackButton() {
        //如果对应的NavigationController，栈中控制器的数量大于1，那么设置返回按钮
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            let normalImage = UIImage(named: "titlebar_back_normal")!
            let backButton = createCustomBarButton(normalImage: normalImage, selector: #selector(tapBackButton(_:)))
            
            let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixedSpace.width = -18
            navigationItem.leftBarButtonItems = [fixedSpace, backButton]
        }
    }
    
    func createCustomBarButton(normalImage: UIImage, highlightImage: UIImage? = nil, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setImage(normalImage, for: .normal)
        button.setImage(highlightImage, for: .highlighted)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }
    
    func handleRequestError(_ error: Error?) {
        if let nserror = error, (nserror as NSError).code == -1009 {
            self.view.showToast("您的网络不给力，请检查网络连接")
        }
        else {
            self.view.showToast("网络错误，请稍后再试")
        }
    }
}
