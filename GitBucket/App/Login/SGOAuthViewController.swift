//
//  SGOAuthViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import WebKit

extension NSNotification.Name {
    static let SGOAuthDidGetTempCode = NSNotification.Name(rawValue: "com.cleanairgames.GitBucket.SGOAuthDidGetTempCode")
}

class SGOAuthViewController: SGWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("decide navigation action: \(navigationAction)")
        if let urlString = navigationAction.request.url?.absoluteString, urlString.contains("https://github.com/buptwsg/SwiftyGitClient?code=") {
            if let code = navigationAction.request.url?.getQueryStringParameter(param: "code") {
                NotificationCenter.default.post(name: NSNotification.Name.SGOAuthDidGetTempCode, object: nil, userInfo: ["code": code])
                decisionHandler(.cancel)
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else {
                assert(false, "oauth code should be there!")
                decisionHandler(.allow)
            }
        }
        else {
            decisionHandler(.allow)
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("decide navigation response")
        decisionHandler(.allow)
    }
}
