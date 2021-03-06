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
    case popularRepos(language: String, page: Int?)
    case popularUsers(location: String, language: String, page: Int?)
    case searchRepos(query: String, language: String, ascending: Bool, page: Int?)
    
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
        let url = try baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        
        var params: Parameters = [:]
        switch self {
        case .showcases, .reposOfCases:
            break
            
        case .trendingRepos(let since, let language):
            params["since"] = since
            params["language"] = language
            
        case .popularRepos(let language, let page):
            params["q"] = " language:\(language)"
            params["sort"] = "stars"
            params["order"] = "desc"
            if nil != page {
                params["page"] = page
            }
            
        case .popularUsers(let location, let language, let page):
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
            if nil != page {
                params["page"] = page
            }
            
        case .searchRepos(let query, let language, let ascending, let page):
            params["q"] = "\(query) language:\(language)"
            params["sort"] = "stars"
            params["order"] = ascending ? "asc" : "desc"
            if nil != page {
                params["page"] = page
            }
        }
        return try URLEncoding.default.encode(request, with: params)
    }
}
