//
//  SGLoginViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import OcticonsKit

class SGLoginViewController: SGBaseViewController {
    @IBOutlet weak var loginButton: SGButton!
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordIcon: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Life Cycle && Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: 22, height: 22)
        self.nameIcon.image = UIImage.octicon(with: .person, textColor: UIColor.darkGray, size: size)
        self.passwordIcon.image = UIImage.octicon(with: .lock, textColor: UIColor.darkGray, size: size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions
    @IBAction func loginToGithub(_ sender: SGButton) {
    }
    
    @IBAction func loginThroughOAuth(_ sender: UIButton) {
    }
}
