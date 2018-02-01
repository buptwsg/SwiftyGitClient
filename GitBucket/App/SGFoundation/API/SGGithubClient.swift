//
//  SGGithubClient.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/1.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire

class SGGithubClient {
    static let baseURL = "https://api.github.com"
    
    static let sessionManager: SessionManager = {
        var defaultHeaders = SessionManager.defaultHTTPHeaders
        defaultHeaders["Accept"] = "application/vnd.github.v3+json"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        return SessionManager(configuration: configuration)
    }()
    
    class func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return self.sessionManager.request(urlRequest)
    }
    
    
}
