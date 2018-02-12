//
//  SGAPIUtility.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/12.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation

func parseNextPage(_ response: HTTPURLResponse) -> Int? {
    let allHeaderFields = response.allHeaderFields
    if let linkField = allHeaderFields["Link"] as? NSString {
        let range = linkField.range(of: "rel=\"next\"")
        if range.location != NSNotFound {
            let substring = linkField.substring(to: range.location) as NSString
            let pageRange = substring.range(of: "?page=")
            let perpageRange = substring.range(of: "&per_page=")
            let pageString = substring.substring(with: NSRange(location: pageRange.location + pageRange.length, length: perpageRange.location - pageRange.location - pageRange.length))
            return Int(pageString)
        }
        else {
            return nil
        }
    }
    
    return nil
}
