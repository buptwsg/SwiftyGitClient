//
//  SGIssue.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

/// An issue on a repository.
class SGIssue: SGObject {
    enum SGIssueState: String {
        case open = "open"
        case closed = "closed"
    }
    
    /// The URL for this issue.
    let issueURL: URL
    
    /// The webpage URL for this issue.
    let htmlURL: URL
    
    ///The title of this issue.
    let title: String
 
    ///The state of the issue.
    let state: SGIssueState
    
    /// The issue number.
    let number: String
    
    let pullRequestHTMLURL: URL?
    
    ///JSON -> Model
    required init(map: Map) throws {
        issueURL = try map.value("url", using: URLTransform())
        htmlURL = try map.value("html_url", using: URLTransform())
        title = try map.value("title")
        state = try map.value("state")
        number = try map.value("number")
        pullRequestHTMLURL = try? map.value("pull_request.html_url", using: URLTransform())
        
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
