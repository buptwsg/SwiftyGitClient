//
//  SGIssueEvent.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

class SGIssueEvent: SGEvent {
    enum SGIssueAction: String {
        case opened = "opened"
        case closed = "closed"
        case reopened = "reopened"
//        case synchronized
    }
    
    let issue: SGIssue
    let action: SGIssueAction
    
    ///JSON -> Model
    required init(map: Map) throws {
        issue = try map.value("payload.issue")
        action = try map.value("payload.action")
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
