//
//  SGPlan.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

/// Represents the billing plan of a GitHub account.
class SGPlan: ImmutableMappable {
    /// The name of this plan.
    let name: String
    
    /// The number of collaborators allowed by this plan.
    let collaborators: UInt
    
    /// The number of kilobytes of disk space allowed by this plan.
    let space: UInt
    
    /// The number of private repositories allowed by this plan.
    let privateRepos: UInt
    
    ///JSON -> Model
    required init(map: Map) throws {
        name = try map.value("name")
        collaborators = try map.value("collaborators")
        space = try map.value("space")
        privateRepos = try map.value("private_repos")
    }
    
    ///Model -> JSON
    func mapping(map: Map) {
    }
}
