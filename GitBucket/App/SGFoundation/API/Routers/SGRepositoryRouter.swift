//
//  SGRepositoryRouter.swift
//  GitBucket
//
//  Created by shuguang on 2018/2/15.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire

enum SGRepositoryRouter: URLRequestConvertible {
    case selfRepositories(page: Int)
    case userRepositories(login: String, page: Int)
    case organizationRepositories(org: String, page: Int)
    case selfStars(page: Int)
    case userStars(login: String, page: Int)
    
    var method: HTTPMethod {
        switch self {
        case .selfRepositories, .userRepositories, .organizationRepositories, .selfStars, .userStars:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .selfRepositories:
            return "/user/repos"
            
        case .userRepositories(let login, _):
            return "/users/\(login)/repos"
            
        case .organizationRepositories(let org, _):
            return "/orgs/\(org)/repos"
            
        case .selfStars:
            return "/user/starred"
            
        case .userStars(let login, _):
            return "/users/\(login)/starred"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try SGGithubClient.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        var params: Parameters = [:]
        switch self {
        case .selfRepositories(let page), .userRepositories(_, let page), .organizationRepositories(_, let page), .selfStars(let page), .userStars(_, let page):
            params["page"] = page
            return try URLEncoding.default.encode(request, with: params)
        }
    }
}
