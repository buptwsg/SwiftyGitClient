//
//  SGGithubClient+Explore.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension SGGithubClient {
    class func fetchShowCases(completion: @escaping ([SGShowCase]?, Error?) -> Void) {
        let request = sessionManager.request(SGExploreRouter.showcases)
        request.responseArray{ (response: DataResponse<[SGShowCase]>) in
            switch response.result {
            case .success(let showcases):
                completion(showcases, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    class func fetchReposForCases(_ cases: String, completion: @escaping ([SGRepository]?, Error?) -> Void) {
        let request = sessionManager.request(SGExploreRouter.reposOfCases(cases: cases))
        request.responseArray { (response: DataResponse<[SGRepository]>) in
            switch response.result {
            case .success(let repositories):
                completion(repositories, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    class func fetchTrendingRepos(since: String, language: String, completion: @escaping ([SGRepository]?, Error?) -> Void) {
        let request = sessionManager.request(SGExploreRouter.trendingRepos(since: since, language: language))
        request.responseArray { (response: DataResponse<[SGRepository]>) in
            switch response.result {
            case .success(let repositories):
                completion(repositories, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    class func fetchPopularRepos(language: String, page: Int? = nil, completion: @escaping ([SGRepository]?, Int?, Error?) -> Void) {
        let request = sessionManager.request(SGExploreRouter.popularRepos(language: language, page: page))
        request.responseArray(keyPath: "items") { (response: DataResponse<[SGRepository]>) in
            switch response.result {
            case .success(let repositories):
                let nextPage = parseNextPage(response.response!)
                completion(repositories, nextPage, nil)
                
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
    
    class func fetchPopularUsers(location: String, language: String, page: Int? = nil, completion: @escaping ([SGUser]?, Int?, Error?) -> Void) {
        let request = sessionManager.request(SGExploreRouter.popularUsers(location: location, language: language, page: page))
        request.responseArray(keyPath: "items") { (response: DataResponse<[SGUser]>) in
            switch response.result {
            case .success(let users):
                let nextPage = parseNextPage(response.response!)
                completion(users, nextPage, nil)
                
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
    
    class func searchRepos(query: String, language: String, ascending: Bool, page: Int?, completion: @escaping ([SGRepository]?, Int?, Error?) -> Void) {
        let request = sessionManager.request(SGExploreRouter.searchRepos(query: query, language: language, ascending: ascending, page: page))
        request.responseArray(keyPath: "items") { (response: DataResponse<[SGRepository]>) in
            switch response.result {
            case .success(let repositories):
                let nextPage = parseNextPage(response.response!)
                completion(repositories, nextPage, nil)
                
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
}
