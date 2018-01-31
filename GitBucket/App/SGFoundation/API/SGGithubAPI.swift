//
//  SGGithubAPI.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/30.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire

class SGGithubAPI {
    var baseURL: String
    var sessionManager: SessionManager
    
    static let `default`: SGGithubAPI = {
        return SGGithubAPI(baseURL: "https://github.com")
    }()
    
    init(baseURL: String) {
        self.baseURL = baseURL
        
        var defaultHeaders = SessionManager.defaultHTTPHeaders
        defaultHeaders["Accept"] = "application/vnd.github.v3+json"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        self.sessionManager = SessionManager(configuration: configuration)
    }
    
    func get(apiPath: String, parameters: Parameters? = nil) throws {
        let urlRequest = try createURLRequest(apiPath, method: .get, parameters: parameters)
        
    }
    
    func post(apiPath: String, parameters: Parameters? = nil) throws {
        
    }
    
    private func createURLRequest(_ apiPath: String, method: HTTPMethod, parameters: Parameters?) throws -> URLRequest {
        let url = try self.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(apiPath))
        urlRequest.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
