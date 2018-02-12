//
//  SGGithubClient+User.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension SGGithubClient {
    class func fetchUserInfo(completion: @escaping (_ user: SGUser?, _ error: Error?) -> Void) {
        sessionManager.request(SGUsersRouter.me).validate().responseObject { (response: DataResponse<SGUser>) in
            switch response.result {
            case .success(let user):
                completion(user, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    class func fetchUserInfo(`for` user: String, completion: @escaping (_ user: SGUser?, _ error: Error?) -> Void) {
        sessionManager.request(SGUsersRouter.someone(userName: user)).validate().responseObject { (response: DataResponse<SGUser>) in
            switch response.result {
            case .success(let user):
                completion(user, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    class func updateUserInfo(name: String?, email: String?, blog: String?, company: String?, location: String?, hireable: Bool?, bio: String?) {
        
    }
    
    class func fetchFollowersForUser(_ user: SGUser, page: Int, completion: @escaping (_ users: [SGUser]?, _ nextPage: Int?, _ error: Error?) -> Void) {
        sessionManager.request(SGUsersRouter.followers(login: user.login!, page: page)).validate().responseArray { (response: DataResponse<[SGUser]>) in
            switch response.result {
            case .success(let usersArray):
                let nextPage = parseNextPage(response.response!)
                completion(usersArray, nextPage, nil)
                
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
    
    class func fetchFollowingsForUser(_ user: SGUser, page: Int, completion: @escaping (_ users: [SGUser]?, _ nextPage: Int?, _ error: Error?) -> Void) {
        let request = sessionManager.request(SGUsersRouter.followings(login: user.login!, page: page))
        request.responseArray { (response: DataResponse<[SGUser]>) in
            switch response.result {
            case .success(let usersArray):
                let nextPage = parseNextPage(response.response!)
                completion(usersArray, nextPage, nil)
                
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
    
    class func doesFollowUser(_ user: SGUser, completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        let request = sessionManager.request(SGUsersRouter.doesFollow(login: user.login!))
        request.validate(statusCode: [204, 404]).responseJSON { response in
            switch response.result {
            case .success(_):
                let result = response.response?.statusCode == 204 ? true : false
                completion(result, nil)
                
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    class func followUser(_ user: SGUser, completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        
    }
    
    class func unfollowUser(_ user: SGUser, completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        
    }
}
