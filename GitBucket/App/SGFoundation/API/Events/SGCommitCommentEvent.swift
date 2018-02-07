//
//  SGCommitCommentEvent.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

class SGCommitCommentEvent: SGEvent {
    let comment: SGCommitComment
    
    ///JSON -> Model
    required init(map: Map) throws {
        comment = try map.value("payload.comment")
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
