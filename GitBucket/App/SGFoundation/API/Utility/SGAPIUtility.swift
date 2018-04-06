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
        let range = linkField.range(of: ">; rel=\"next\"")
        if range.location != NSNotFound {
            let questionMarkRange = linkField.range(of: "?")
            let paramsRange = NSRange(location: questionMarkRange.location + 1, length: range.location - questionMarkRange.location - 1)
            let substring = linkField.substring(with: paramsRange) as NSString
            let components = substring.components(separatedBy: "&")
            var paramsDict = [String : String]()
            for paramPair in components {
                let pair = paramPair.components(separatedBy: "=")
                paramsDict[pair[0]] = pair[1]
            }
            
            if let pageString = paramsDict["page"] {
                return Int(pageString)
            }
        }
        else {
            return nil
        }
    }
    
    return nil
}
