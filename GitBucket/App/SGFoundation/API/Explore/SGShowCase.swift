//
//  SGShowCase.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

class SGShowCase: ImmutableMappable {
    let name: String
    let description: String
    let image_url: URL
    let slug: String
    
    ///JSON -> Model
    required init(map: Map) throws {
        name = try map.value("name")
        description = try map.value("description")
        image_url = try map.value("image_url", using: URLTransform())
        slug = try map.value("slug")
    }
    
    ///Model -> JSON
    func mapping(map: Map) {
    }
}
