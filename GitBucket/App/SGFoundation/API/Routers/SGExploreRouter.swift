//
//  SGExploreRouter.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire

enum SGExploreRouter: URLRequestConvertible {
    case showcases
    case reposOfCases(cases: String)
    case trendingRepos(since: String, language: String)
    case popularRepos(language: String)
    case popularUsers(location: String, language: String)
    case searchRepos(query: String, language: String, ascending: Bool)
    
    var baseURL: String {
        switch self {
        case .showcases, .reposOfCases, .trendingRepos:
            return "http://trending.leichunfeng.com"
            
        case .popularRepos, .popularUsers, .searchRepos:
            return SGGithubClient.baseURL
        }
    }
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var path: String {
        switch self {
        case .showcases:
            return "/v2/showcases"
            
        case .reposOfCases(let cases):
            return "/v2/showcases/\(cases)"
            
        case .trendingRepos:
            return "/v2/trending"
            
        case .popularRepos, .searchRepos:
            return "/search/repositories"
            
        case .popularUsers:
            return "/search/users"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try SGGithubClient.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        var params: Parameters = [:]
        switch self {
        case .showcases, .reposOfCases:
            break
            
        case .trendingRepos(let since, let language):
            params["since"] = since
            params["language"] = language
            
        case .popularRepos(let language):
            params["q"] = " language:\(language)"
            params["sort"] = "stars"
            params["order"] = "desc"
            
        case .popularUsers(let location, let language):
            var query = " followers:>=1"
            if !location.isEmpty {
                query += " location:\(location)"
            }
            if !language.isEmpty {
                query += " language:\(language)"
            }
            
            params["q"] = query
            params["sort"] = "followers"
            params["order"] = "desc"
            
        case .searchRepos(let query, let language, let ascending):
            params["q"] = "\(query) language:\(language)"
            params["sort"] = "stars"
            params["order"] = ascending ? "asc" : "desc"
        }
        return try URLEncoding.default.encode(request, with: params)
    }
}
