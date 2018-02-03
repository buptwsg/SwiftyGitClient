//
//  SGGithubOAuth.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/31.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire

/**
 职责：
 1. 有access token时，在请求的头里加上
 2. 构建OAuth的URL，传入webview
 3. 实现OAuth认证的两个流程
 4. 刷新token，
 */
class SGGithubOAuth: NSSecureCoding, RequestAdapter, RequestRetrier {
    static let `default`: SGGithubOAuth = {
        return SGGithubOAuth()
    }()
    
    private let sessionManager: SessionManager = SGGithubClient.sessionManager
    private var accessToken = ""
    private var refreshToken = ""
    private let clientID = "85381c27c9a597de5b1d"
    private let clientSecret = "d23a3c20af26060c1548263197180fe5f3e89106"
    private let baseURLString: String = SGGithubClient.baseURL
    
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
    
    //MARK: Constructor
    init() {
        commonInit()
    }
    
    func commonInit() {
        self.sessionManager.adapter = self
        self.sessionManager.retrier = self
    }
    
    //MARK: Public functions
    /**
     利用Basic Authorization来得到OAuth2的token
    */
    func createAssessTokenByBasicAuthorization(user: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        let request = sessionManager.request(OAuthRouter.basic(user: user, password: password, clientID: clientID, clientSecret: clientSecret))
        debugPrint(request)
        request.validate().responseJSON{ response in
            print(response)
            switch response.result {
            case .success:
                if let json = response.result.value as? [String : Any], let token = json["token"], token is String {
                    self.accessToken = token as! String
                    completion(true)
                }
                else {
                    completion(false)
                }
                
            case .failure(let error):
                print("create access token failed: \(error)")
                completion(false)
            }
        }
    }
    
    /**
     基于Web的OAuth认证，创建相应的URLRequest
    */
    var oauthWebFlowUrlRequest: URLRequest? {
        do {
            return try OAuthRouter.oauth(clientID: self.clientID).asURLRequest()
        }
        catch {
            return nil
        }
    }
    
    /**
     利用临时的token，去交换OAuth2的token
    */
    func exchangeAccessToken(code: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        let request = sessionManager.request(OAuthRouter.token(clientID: clientID, clientSecret: clientSecret, code: code))
        debugPrint(request)
        
        request.validate().responseJSON { response in
            print(response)
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: Any], let token = json["access_token"], token is String {
                    self.accessToken = token as! String
                    completion(true, nil)
                }
                else {
                    completion(false, nil)
                }
                
            case .failure(let error):
                print("exchange access token failed: \(error)")
                completion(false, error)
            }
        }
    }
    //
    //MARK: NSSecureCoding
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encode(with aCoder: NSCoder) {
    }
    
    //MARK: RequestAdapter
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if accessToken.isEmpty {
            return urlRequest
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue("token " + accessToken, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    //疑问，在成功的情况下，这个代理方法是否会被调用？如果每次都被调用，那每次都得加锁，解锁，性能不高吧
    // MARK: - RequestRetrier
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken, refreshToken in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    
                    if let accessToken = accessToken, let refreshToken = refreshToken {
                        strongSelf.accessToken = accessToken
                        strongSelf.refreshToken = refreshToken
                    }
                    
                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        }
        else {
            completion(false, 0.0)
        }
    }
    
    // MARK: - Private - Refresh Tokens
    //下面的代码未测试
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else {
            return
        }
        
        isRefreshing = true
        
        let urlString = "\(baseURLString)/oauth2/token"
        
        let parameters: Parameters = [
            "access_token": accessToken,
            "refresh_token": refreshToken,
            "client_id": clientID,
            "grant_type": "refresh_token"
        ]
        
        self.sessionManager.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { [weak self] response in
                guard let strongSelf = self else { return }
                
                if  let json = response.result.value as? [String: Any],
                    let accessToken = json["access_token"] as? String,
                    let refreshToken = json["refresh_token"] as? String
                {
                    completion(true, accessToken, refreshToken)
                }
                else {
                    completion(false, nil, nil)
                }
                
                strongSelf.isRefreshing = false
        }
    }
}
