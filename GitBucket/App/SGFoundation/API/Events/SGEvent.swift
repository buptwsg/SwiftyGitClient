//
//  SGEvent.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Base event class
 */
class SGEvent: SGObject {
    ///The name of the repository upon which the event occurred (e.g., `github/Mac`).
    let repositoryName: String
    
    ///The login of the user who instigated the event.
    let actorLogin: String
    
    ///The URL for the avatar of the user who instigated the event.
    let actorAvatarURL: URL
    
    ///The organization related to the event.
    let organizationLogin: String
    
    ///The date that this event occurred.
    let date: Date
    
    ///JSON -> Model
    required init(map: Map) throws {
        repositoryName = try map.value("repo.name")
        actorLogin = try map.value("actor.login")
        actorAvatarURL = try map.value("actor.avatar_url", using: URLTransform())
        organizationLogin = try map.value("org.login")
        date = try map.value("created_at", using: SGDateStringTransform())
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
