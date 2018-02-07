//
//  SGRefEvent.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

class SGRefEvent: SGEvent {
    enum SGRefType: String {
        case branch = "branch"
        case tag = "tag"
        case repository = "repository"
    }
    
    enum SGRefEventType: String {
        case created = "CreateEvent"
        case deleted = "DeleteEvent"
    }
    
    ///The kind of reference that was created or deleted.
    let refType: SGRefType
    
    ///The type of event that occurred with the reference.
    let eventType: SGRefEventType
    
    ///The short name of this reference (e.g., "master").
    let refName: String
    
    ///JSON -> Model
    required init(map: Map) throws {
        refType = try map.value("payload.ref_type")
        eventType = try map.value("type")
        refName = try map.value("payload.ref")
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
