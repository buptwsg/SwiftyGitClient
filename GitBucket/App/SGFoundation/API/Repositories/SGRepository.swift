//
//  SGRepository.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

///A GitHub repository
class SGRepository: SGObject {
    ///The name of this repository, as used in GitHub URLs.
    let name: String
    
    ///The login of the account which owns this repository.
    let ownerLogin: String
    
    /// The URL for any avatar image.
    let ownerAvatarURL: URL
    
    /// The description of this repository.
    let repoDescription: String
    
    /// The language of this repository.
    let language: String
    
    /// Whether this repository is private to the owner.
    let isPrivate: Bool
    
    /// Whether this repository is a fork of another repository.
    let isFork: Bool
    
    /// The date of the last push to this repository.
    let datePushed: Date?
    
    /// The created date of this repository.
    let dateCreated: Date?
    
    /// The last updated date of this repository.
    let dateUpdated: Date?
    
    /// The number of watchers for this repository.
    let watchersCount: UInt
    
    /// The number of forks for this repository.
    let forksCount: UInt
    
    /// The number of stargazers for this repository.
    let stargazersCount: UInt
    
    /// The number of open issues for this repository.
    let openIssuesCount: UInt
    
    /// The number of subscribers for this repository.
    let subscribersCount: UInt
    
    /// The URL for pushing and pulling this repository over HTTPS.
    let httpsURL: URL
    
    /// The URL for pushing and pulling this repository over SSH, formatted as
    /// a string because SSH URLs are not correctly interpreted by NSURL.
    let sshURL: URL
    
    /// The URL for pulling this repository over the `git://` protocol.
    let gitURL: URL
    
    /// The URL for visiting this repository on the web.
    let htmlURL: URL
    
    /// The default branch's name. For empty repositories, this will be nil.
    let defaultBranch: String?
    
    /// The URL for the issues page in a repository.
    ///
    /// An issue number may be appended (as a path component) to this path to create
    /// an individual issue's HTML URL.
    let issuesHTMLURL: URL
    
    /// Text match metadata, uses to highlight the search results.
    let textMatches: [String]
    
    /// The parent of the fork, or nil if the repository isn't a fork. This is the
    /// repository from which the receiver was forked.
    let forkParent: SGRepository?
    
    /// The source of the fork, or nil if the repository isn't a fork. This is the
    /// ultimate source for the network, which may be different from the
    /// `forkParent`.
    let forkSource: SGRepository?
    
    ///JSON -> Model
    required init(map: Map) throws {
        let urlTransform = URLTransform()
        let dateTransform = SGDateStringTransform()
        
        name = try map.value("name")
        ownerLogin = try map.value("owner.login")
        ownerAvatarURL = try map.value("owner.avatar_url", using: urlTransform)
        repoDescription = try map.value("description")
        language = try map.value("language")
        isPrivate = try map.value("private")
        isFork = try map.value("fork")
        datePushed = try map.value("pushed_at", using: dateTransform)
        dateCreated = try map.value("created_at", using: dateTransform)
        dateUpdated = try map.value("updated_at", using: dateTransform)
        watchersCount = try map.value("watchers_count")
        forksCount = try map.value("forks_count")
        stargazersCount = try map.value("stargazers_count")
        openIssuesCount = try map.value("open_issues_count")
        subscribersCount = try map.value("subscribers_count")
        httpsURL = try map.value("clone_url", using: urlTransform)
        sshURL = try map.value("ssh_url", using: urlTransform)
        gitURL = try map.value("git_url", using: urlTransform)
        htmlURL = try map.value("html_url", using: urlTransform)
        defaultBranch = try map.value("default_branch")
        issuesHTMLURL = try map.value("issuesHTMLURL", using: urlTransform)
        textMatches = try map.value("text_matches")
        forkParent = try? map.value("parent")
        forkSource = try? map.value("source")
        try super.init(map: map)
    }
    
    ///Model -> JSON
    override func mapping(map: Map) {
    }
}
