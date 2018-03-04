//
//  SGSegmentedControlViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/4.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGSegmentedControlViewController: SGBaseViewController {
    var segmentedControl: UISegmentedControl?
    var currentViewController: UIViewController?
    
    var viewControllers: [UIViewController] = [] {
        didSet {
            assert(viewControllers.count > 0, "SGSegmentedControlViewController's viewControllers is empty array")
            let currentVC = viewControllers[0]
            addChildViewController(currentVC)
            currentVC.view.frame = self.view.bounds
            self.view.addSubview(currentVC.view)
            currentVC.didMove(toParentViewController: self)
            
            self.currentViewController = currentVC
            let titlesArray = viewControllers.map{vc in
                return vc.segmentedTitle
            }
            segmentedControl = UISegmentedControl(items: titlesArray)
            segmentedControl?.selectedSegmentIndex = 0
            navigationItem.titleView = segmentedControl
            segmentedControl?.addTarget(self, action: #selector(segmentedControlIndexChanged(_:)), for: .valueChanged)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func segmentedControlIndexChanged(_ segmentedControl: UISegmentedControl) {
        if let currentViewController = self.currentViewController {
            let toViewController = viewControllers[segmentedControl.selectedSegmentIndex]
            cycle(fromViewController: currentViewController, toViewController: toViewController)
        }
    }
    
    func cycle(fromViewController: UIViewController, toViewController: UIViewController) {
        fromViewController.willMove(toParentViewController: nil)
        addChildViewController(toViewController)
        toViewController.view.frame = self.view.bounds
        
        transition(from: fromViewController, to: toViewController, duration: 0, options: [], animations: nil) { finished in
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
            
            self.currentViewController = toViewController
        }
    }
}

private var key: Void?

extension UIViewController {
    
    var segmentedTitle: String {
        get {
            return objc_getAssociatedObject(self, &key) as! String
        }
        
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
