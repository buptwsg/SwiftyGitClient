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
}
