//
//  SGIssueComment.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

///A single comment on an issue.
class SGIssueComment: SGObject {
    /// The webpage URL for this comment.
    let htmlURL: URL
    
    ///The login of the user who created this comment.
    let commenterLogin: String
    
    ///The date at which the comment was originally created.
    let creationDate:  Date?
    
    /// The date the comment was last updated. This will be equal to
    /// creationDate if the comment has not been updated.
    let updatedDate: Date?
    
    ///JSON -> Model
    required init(map: Map) throws {
        htmlURL = try map.value("html_url", using: URLTransform())
        commenterLogin = try map.value("user.login")
        creationDate = try? map.value("created_at", using: SGDateStringTransform())
        updatedDate = try? map.value("updated_at", using: SGDateStringTransform())
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
