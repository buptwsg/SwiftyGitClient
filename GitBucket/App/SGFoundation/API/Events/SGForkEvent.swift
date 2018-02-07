//
//  SGForkEvent.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

///A user forked a repository.
class SGForkEvent: SGEvent {
    ///The name of the repository created by forking (e.g., `user/Mac`).
    let forkedRepositoryName: String
    
    ///JSON -> Model
    required init(map: Map) throws {
        forkedRepositoryName = try map.value("payload.forkee.full_name")
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
