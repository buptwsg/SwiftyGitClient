//
//  SGAPIUtility.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/12.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation

/*
 Link = "<https://api.github.com/search/repositories?order=desc&page=2&q=afn+language%3Aobjective-c&sort=stars>; rel=\"next\", <https://api.github.com/search/repositories?order=desc&page=28&q=afn+language%3Aobjective-c&sort=stars>; rel=\"last\"";
这种情况下还是会出问题
 */

func parseNextPage(_ response: HTTPURLResponse) -> Int? {
    let allHeaderFields = response.allHeaderFields
    if let linkField = allHeaderFields["Link"] as? NSString {
        let range = linkField.range(of: "rel=\"next\"")
        if range.location != NSNotFound {
            let substring = linkField.substring(to: range.location) as NSString
            let pageRange = substring.range(of: "page=", options: [.backwards])
            let pageEndRange = substring.range(of: ">;", options: [.backwards])
            let pageString = substring.substring(with: NSRange(location: pageRange.location + pageRange.length, length: pageEndRange.location - pageRange.location - pageRange.length))
            return Int(pageString)
        }
        else {
            return nil
        }
    }
    
    return nil
}
