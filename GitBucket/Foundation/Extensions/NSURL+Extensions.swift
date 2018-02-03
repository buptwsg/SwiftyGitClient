//
//  NSURL+Extensions.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/2/3.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
extension URL {
    func getQueryStringParameter(param: String) -> String? {
        guard let urlComponents = NSURLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = urlComponents.queryItems else {
                return nil
        }
        
        return queryItems.first(where: { $0.name == param })?.value
    }
}
