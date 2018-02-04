//
//  SGLoginViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import OcticonsKit
import MBProgressHUD

class SGLoginViewController: SGBaseViewController, UITextFieldDelegate {
    @IBOutlet weak var loginButton: SGButton!
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordIcon: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var githubIcon: UIImageView!
    
    //MARK: Life Cycle && Overrides
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: 22, height: 22)
        self.nameIcon.image = UIImage.octicon(with: .person, textColor: UIColor.darkGray, size: size)
        self.passwordIcon.image = UIImage.octicon(with: .lock, textColor: UIColor.darkGray, size: size)
        self.githubIcon.image = UIImage(named: "Icon-60")
        
        self.nameTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        
        updateLoginButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetOauthCode(_:)), name: NSNotification.Name.SGOAuthDidGetTempCode, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: IBActions
    @IBAction func loginToGithub(_ sender: SGButton) {
        SGGithubOAuth.default.createAssessTokenByBasicAuthorization(user: self.nameTextField.text!, password: self.passwordTextField.text!) { success in
            print("auth result is \(success)")
        }
    }
    
    @IBAction func loginThroughOAuth(_ sender: UIButton) {
        let oauthVC = SGOAuthViewController()
        oauthVC.urlRequest = SGGithubOAuth.default.oauthWebFlowUrlRequest
        navigationController?.pushViewController(oauthVC, animated: true)
    }
    
    @objc
    func textDidChanged(_ textField: UITextField) {
        updateLoginButton()
    }
    
    @objc
    func didGetOauthCode(_ notification: Notification) {
        if let userInfo = notification.userInfo, let code = userInfo["code"] as? String {
            print("code is : \(code)")
            
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = "正在完成认证，请稍候"
            SGGithubOAuth.default.exchangeAccessToken(code: code) { success, error in
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if success {
                    let rootVC = SGRootTabBarViewController.instance
                    self.view.window?.rootViewController = rootVC
                }
                else {
                    self.view.makeToast("交换Token失败！")
                }
            }
        }
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
