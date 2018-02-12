//
//  SGUsersRouter.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire

enum SGUsersRouter: URLRequestConvertible {
    case me
    case someone(userName: String)
    case updateProfile(name: String?, email: String?, blog: String?, company: String?, location: String?, hireable: Bool?, bio: String?)
    case followers(login: String, page: Int)
    case followings(login: String, page: Int)
    case doesFollow(login: String)
    case follow(login: String)
    case unfollow(login: String)
    
    var method: HTTPMethod {
        switch self {
        case .me, .someone, .followers, .followings, .doesFollow:
            return .get
            
        case .updateProfile:
            return .patch
            
        case .follow:
            return .put
            
        case.unfollow:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .me, .updateProfile:
            return "/user"
            
        case .someone(let userName):
            return "/users/\(userName)"
            
        case .followers(let login, _):
            return "/users/\(login)/followers"
            
        case .followings(let login, _):
            return "/users/\(login)/following"
            
        case .doesFollow(let login), .follow(let login), .unfollow(let login):
            return "/user/following/\(login)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try SGGithubClient.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        switch self {
        case .me, .someone, .doesFollow, .unfollow:
            return try URLEncoding.default.encode(request, with: nil)
            
        case .follow:
            request.setValue("0", forHTTPHeaderField: "Content-Length")
            return try URLEncoding.default.encode(request, with: nil)
            
        case .updateProfile(let name, let email, let blog, let company, let location, let hireable, let bio):
            var params: Parameters = [:]
            if nil != name {
                params["name"] = name
            }
            if nil != email {
                params["email"] = email
            }
            if nil != blog {
                params["blog"] = blog
            }
            if nil != company {
                params["company"] = company
            }
            if nil != location {
                params["location"] = location
            }
            if nil != hireable {
                params["hireable"] = hireable
            }
            if nil != bio {
                params["bio"] = bio
            }
            return try JSONEncoding.default.encode(request, with: params)
            
        case .followers(_, let page), .followings(_, let page):
            let params: Parameters = ["page": page]
            return try URLEncoding.default.encode(request, with: params)
        }
    }
}
