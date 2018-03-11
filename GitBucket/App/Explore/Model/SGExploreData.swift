//
//  SGExploreData.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/10.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

class SGExploreData: ImmutableMappable, CustomStringConvertible, Equatable {
    let name: String
    let slug: String
    
    init(name: String, slug: String) {
        self.name = name
        self.slug = slug
    }
    
    ///JSON -> Model
    required init(map: Map) throws {
        name = try map.value("name")
        slug = try map.value("slug")
    }
    
    ///Model -> JSON
    func mapping(map: Map) {
        name >>> map["name"]
        slug >>> map["slug"]
    }
    
    var description: String {
        return "{name=\(name), slug=\(slug)}"
    }
    
    static func == (lhs: SGExploreData, rhs: SGExploreData) -> Bool {
        return lhs.name == rhs.name && lhs.slug == rhs.slug
    }
    
    static func != (lhs: SGExploreData, rhs: SGExploreData) -> Bool {
        return !(lhs == rhs)
    }
}

func exploreDataFromResouce(_ resource: String) -> [SGExploreData] {
    if let jsonPath = Bundle.main.url(forResource: resource, withExtension: "json") {
        do {
            let jsonData = try Data(contentsOf: jsonPath)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as! [Any]
            var resultArray = [SGExploreData]()
            
            for dict in jsonObject {
                let data = try SGExploreData(JSONObject: dict)
                resultArray.append(data)
            }
            return resultArray
        }
        catch {
            return []
        }
    }
    else {
        return []
    }
}
