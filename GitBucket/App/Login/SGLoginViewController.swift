//
//  SGLoginViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import OcticonsKit

class SGLoginViewController: SGBaseViewController, UITextFieldDelegate {
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
        
        self.nameTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        
        updateLoginButton()
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
        SGGithubOAuth.default.createAssessTokenByBasicAuthorization(user: self.nameTextField.text!, password: self.passwordTextField.text!) { success in
            print("auth result is \(success)")
        }
    }
    
    @IBAction func loginThroughOAuth(_ sender: UIButton) {
    }
    
    @objc
    func textDidChanged(_ textField: UITextField) {
        updateLoginButton()
    }
    
    //MARK: Private
    private func updateLoginButton() {
        guard let name = self.nameTextField.text, let password = self.passwordTextField.text else {
            self.loginButton.isEnabled = false
            return
        }
        
        if !name.isEmpty && !password.isEmpty {
            self.loginButton.isEnabled = true
        }
        else {
            self.loginButton.isEnabled = false
        }
    }
}