//
//  SGMemberEvent.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

/// A user was added as a collaborator to a repository.
class SGMemberEvent: SGEvent {
    /// The login of the user that was added to the repository.
    let memberLogin: String
    
    ///JSON -> Model
    required init(map: Map) throws {
        memberLogin = try map.value("payload.member.login")
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
