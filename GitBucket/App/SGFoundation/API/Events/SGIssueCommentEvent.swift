//
//  SGIssueCommentEvent.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

///A user commented on an issue.
class SGIssueCommentEvent: SGEvent {
    ///The comment that was posted.
    let comment: SGIssueComment
    
    /// The issue upon which the comment was posted.
    let issue: SGIssue
    
    ///JSON -> Model
    required init(map: Map) throws {
        comment = try map.value("payload.comment")
        issue = try map.value("payload.issue")
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
