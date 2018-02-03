//
//  SGWebViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import WebKit

class SGWebViewController: SGBaseViewController, WKNavigationDelegate {
    var urlRequest: URLRequest?
    var urlString: String?
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let request = self.urlRequest {
            self.webView.load(request)
        }
        else if let urlString = self.urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start to load")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("load failed")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("load finished")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}
