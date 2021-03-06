//
//  SGEntity.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

/// Represents any GitHub object which is capable of owning repositories.
class SGEntity: ImmutableMappable {
    /// The unique name for this entity, used in GitHub URLs.
    let login: String?
    
    /// The full name of this entity.
    /// Returns `login` if no name is explicitly set.
    let name: String?
    
    /// The short biography associated with this account.
    let bio: String?
    
    /// The email address for this account.
    let email: String?
    
    /// The URL for any avatar image.
    let avatarURL: URL?
    
    /// The web URL for this account.
    let htmlURL: URL?
    
    /// A reference to a blog associated with this account.
    let blog: String?
    
    /// The name of a company associated with this account.
    let company: String?
    
    /// The location associated with this account.
    let location: String?
    
    ///whether the user is hireable for job
    let hireable: Bool?
    
    /// The total number of collaborators that this account has on their private repositories.
    let collaborators: UInt?
    
    /// The number of public repositories owned by this account.
    let publicRepoCount: UInt?
    
    /// The number of private repositories owned by this account.
    let privateRepoCount: UInt?
    
    /// The number of public gists owned by this account.
    let publicGistCount: UInt?
    
    /// The number of private gists owned by this account.
    let privateGistCount: UInt?
    
    /// The number of followers for this account.
    let followers: UInt?
    
    /// The number of following for this account.
    let following: UInt?
    
    /// The number of kilobytes occupied by this account's repositories on disk.
    let diskUsage: UInt?
    
    /// The plan that this account is on.
    let plan: SGPlan?
    
    ///JSON -> Model
    required init(map: Map) throws {
        let urlTransform = URLTransform()
        
        login = try? map.value("login")
        name = try? map.value("name")
        bio = try? map.value("bio")
        email = try? map.value("email")
        avatarURL = try? map.value("avatar_url", using: urlTransform)
        htmlURL = try? map.value("html_url", using: urlTransform)
        blog = try? map.value("blog")
        company = try? map.value("company")
        location = try? map.value("location")
        
        hireable = try? map.value("hireable")
        collaborators = try? map.value("collaborators")
        publicRepoCount = try? map.value("public_repos")
        privateRepoCount = try? map.value("owned_private_repos")
        publicGistCount = try? map.value("public_gists")
        privateGistCount = try? map.value("private_gists")
        followers = try? map.value("followers")
        following = try? map.value("following")
        diskUsage = try? map.value("disk_usage")
        
        plan = try? map.value("plan")
    }
    
    ///Model -> JSON
    func mapping(map: Map) {
        let urlTransform = URLTransform()
        
        login >>> map["login"]
        name >>> map["name"]
        bio >>> map["bio"]
        email >>> map["email"]
        avatarURL >>> (map["avatar_url"], urlTransform)
        htmlURL >>> (map["html_url"], urlTransform)
        blog >>> map["blog"]
        company >>> map["company"]
        location >>> map["location"]
        
        hireable >>> map["hireable"]
        collaborators >>> map["collaborators"]
        publicRepoCount >>> map["public_repos"]
        privateRepoCount >>> map["owned_private_repos"]
        publicGistCount >>> map["public_gists"]
        privateGistCount >>> map["private_gists"]
        followers >>> map["followers"]
        following >>> map["following"]
        diskUsage >>> map["disk_usage"]
        
        plan >>> map["plan"]
    }
}

extension SGEntity {
    var displayName: String {
        if nil != name {
            return name!
        }
        else if nil != login {
            return login!
        }
        else {
            return "Unknown Name"
        }
    }
    
    var displayBio: String {
        if let bio = self.bio, !bio.isEmpty {
            return bio
        }
        else {
            return "Not Set"
        }
    }
    
    var displayEmail: String {
        if let email = self.email, !email.isEmpty {
            return email
        }
        else {
            return "Not Set"
        }
    }
    
    var displayBlog: String {
        if let blog = self.blog, !blog.isEmpty {
            return blog
        }
        else {
            return "Not Set"
        }
    }
    
    var displayCompany: String {
        if let company = self.company, !company.isEmpty {
            return company
        }
        else {
            return "Not Set"
        }
    }
    
    var displayLocation: String {
        if let location = self.location, !location.isEmpty {
            return location
        }
        else {
            return "Not Set"
        }
    }
    
    var displayHireable: String {
        if let hire = hireable {
            return hire ? "Hireable" : "Not Hireable"
        }
        else {
            return "Not Hireable"
        }
    }
}
