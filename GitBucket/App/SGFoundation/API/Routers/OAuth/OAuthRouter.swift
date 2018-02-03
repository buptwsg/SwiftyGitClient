//
//  OAuthRouter.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/1.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire

enum OAuthRouter: URLRequestConvertible {
    case basic(user: String, password: String, clientID: String, clientSecret: String)
    case oauth(clientID: String)
    
    var baseURL: String {
        switch self {
        case .basic:
            return SGGithubClient.baseURL
            
        case .oauth:
            return "https://github.com"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .basic:
            return .post
            
        case .oauth:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .basic:
            return "/authorizations"
            
        case .oauth:
            return "/login/oauth/authorize"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .basic(let user, let password, let clientID, let clientSecret):
            let parameters: Parameters = [
                "scopes": ["user", "repo", "admin:org", "gist", "delete_repo"],
                "note": "SwiftyGit",
                "note_url": "https://github.com/buptwsg/SwiftyGitClient",
                "client_id": clientID,
                "client_secret": clientSecret
            ]
            
            if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
                urlRequest.setValue(authorizationHeader.value, forHTTPHeaderField: authorizationHeader.key)
            }
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
        case .oauth(let clientID):
            let parameters: Parameters = [
                "scope": "user repo admin:org gist delete_repo",
                "client_id": clientID
            ]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
