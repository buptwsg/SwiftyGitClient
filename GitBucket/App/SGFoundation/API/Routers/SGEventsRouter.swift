//
//  EventsRouter.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/6.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire

enum SGEventsRouter: URLRequestConvertible {
    ///List events that a user has received
    ///
    ///- user: github user name
    ///- page: page to load
    case received(user: String, page: Int)
    
    ///List events performed by a user
    ///
    ///- user: github user name
    ///- page: page to load
    case performed(user: String, page: Int)
    
    var path: String {
        switch self {
        case .received(let user, _):
            return "/users/\(user)/received_events"
            
        case .performed(let user, _):
            return "/users/\(user)/events"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try SGGithubClient.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = HTTPMethod.get.rawValue
        
        var params: Parameters = [:]
        switch self {
        case .received(_, let page), .performed(_, let page):
            params["page"] = page
        }
        
        return try URLEncoding.default.encode(request, with: params)
    }
}
