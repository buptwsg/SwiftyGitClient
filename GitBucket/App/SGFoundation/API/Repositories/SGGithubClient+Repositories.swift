//
//  SGGithubClient+Repositories.swift
//  GitBucket
//
//  Created by shuguang on 2018/2/16.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension SGGithubClient {
    ///获取仓库列表，当login为nil时，获取当前登录用户的仓库列表；否则获取的是指定用户的仓库列表。
    ///访问接口时，参数都为默认值。具体可见https://developer.github.com/v3/repos/
    class func fetchRepositories(login: String? = nil, page: Int, completion: @escaping ([SGRepository]?, Int?, Error?) -> Void) {
        var router: SGRepositoryRouter
        if let login = login {
            router = SGRepositoryRouter.userRepositories(login: login, page: page)
        }
        else {
            router = SGRepositoryRouter.selfRepositories(page: page)
        }
        
        sessionManager.request(router).validate().responseArray { (response: DataResponse<[SGRepository]>) in
            switch response.result {
            case .success(let repos):
                let nextPage = parseNextPage(response.response!)
                completion(repos, nextPage, nil)
                
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
    
    class func fetchRepositoriesForOrganization(_ org: String, page: Int, completion: @escaping ([SGRepository]?, Int?, Error?) -> Void) {
        sessionManager.request(SGRepositoryRouter.organizationRepositories(org: org, page: page)).validate().responseArray { (response: DataResponse<[SGRepository]>) in
            switch response.result {
            case .success(let repos):
                let nextPage = parseNextPage(response.response!)
                completion(repos, nextPage, nil)
                
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
    
    class func fetchStarredRepositories(login: String? = nil, page: Int, completion: @escaping ([SGRepository]?, Int?, Error?) -> Void) {
        var router: SGRepositoryRouter
        if let login = login {
            router = SGRepositoryRouter.userStars(login: login, page: page)
        }
        else {
            router = SGRepositoryRouter.selfStars(page: page)
        }
        
        sessionManager.request(router).validate().responseArray { (response: DataResponse<[SGRepository]>) in
            switch response.result {
            case .success(let repos):
                let nextPage = parseNextPage(response.response!)
                completion(repos, nextPage, nil)
                
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
}
