//
//  SGObject.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 The base model class for any objects retrieved through the GitHub API.
 */
class SGObject: ImmutableMappable {
    /// The unique ID for this object. This is only guaranteed to be unique among
    /// objects of the same type, from the same server.
    let objectID: String
    
    ///JSON -> Model
    required init(map: Map) throws {
        objectID = try map.value("id")
    }
    
    ///Model -> JSON
    func mapping(map: Map) {
    }
}
