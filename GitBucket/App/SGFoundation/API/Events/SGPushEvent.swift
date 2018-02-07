//
//  SGPushEvent.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

///Some commits got pushed.
class SGPushEvent: SGEvent {
    ///The number of commits included in this push.
    let commitCount: UInt
    
    ///The number of distinct commits included in this push.
    let distinctCommitCount: UInt
    
    ///The SHA for HEAD prior to this push.
    let previousHeadSHA: String
    
    ///The SHA for HEAD after this push.
    let currentHeadSHA: String
    
    ///The branch to which the commits were pushed.
    let branchName: String
    
    ///The commits were pushed, in which was the NSDictionary object.
    let commits: [Any]
    
    ///JSON -> Model
    required init(map: Map) throws {
        commitCount = try map.value("payload.size")
        distinctCommitCount = try map.value("payload.distinct_size")
        previousHeadSHA = try map.value("payload.before")
        currentHeadSHA = try map.value("payload.head")
        branchName = try map.value("payload.ref")
        commits = try map.value("payload.commits")
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
