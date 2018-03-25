//
//  AppData.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

class AppData: Mappable {
    var user: SGUser? = nil
    var countryDataOfPopularUsers: SGExploreData? = nil
    var languageDataOfPopularUsers: SGExploreData? = nil
    var languageDataOfPopularRepos: SGExploreData? = nil
    var languageDataOfTrendingRepos: SGExploreData? = nil
    var languageDataOfSearch: SGExploreData? = nil
    
    private static let archivePath: String = {
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docURL.appendingPathComponent("appdata.bin").path
    }()
    
    static let `default`: AppData = {
        let path = archivePath
        if FileManager.default.fileExists(atPath: path) {
            do {
                let jsonString = try String(contentsOfFile: path)
                if let instance = AppData(JSONString: jsonString) {
                    return instance
                }
                else {
                    return AppData()
                }
            }
            catch {
                return AppData()
            }
        }
        else {
            return AppData()
        }
    }()
    
    init() {
        countryDataOfPopularUsers = SGExploreData(name: "All Countries", slug: "")
        languageDataOfPopularUsers = SGExploreData(name: "All Languages", slug: "")
        languageDataOfPopularRepos = SGExploreData(name: "All Languages", slug: "")
        languageDataOfTrendingRepos = SGExploreData(name: "All Languages", slug: "")
        languageDataOfSearch = SGExploreData(name: "All Languages", slug: "")
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        countryDataOfPopularUsers <- map["countryDataOfPopularUsers"]
        languageDataOfPopularUsers <- map["languageDataOfPopularUsers"]
        languageDataOfPopularRepos <- map["languageDataOfPopularRepos"]
        languageDataOfTrendingRepos <- map["languageDataOfTrendingRepos"]
        languageDataOfSearch <- map["languageDataOfSearch"]
    }
    
    func save() {
        let path = type(of: self).archivePath
        let jsonString = self.toJSONString(prettyPrint: true)
        do {
            try jsonString?.write(toFile: path, atomically: true, encoding: .utf8)
        }
        catch (let error) {
            print("save app data error: \(error.localizedDescription)")
        }
    }
    
    func isLoggedUser(_ anotherEntity: SGEntity) -> Bool {
        return user?.login == anotherEntity.login
    }
}
