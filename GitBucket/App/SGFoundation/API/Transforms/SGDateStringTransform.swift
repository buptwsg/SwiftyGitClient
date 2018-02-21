//
//  SGDateStringTransform.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/7.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation
import ObjectMapper

class SGDateStringTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    let formatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //All timestamps in Github API return in ISO 8601 format
        return dateFormatter
    }()
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        guard let dateString = value as? String else { return nil }
        let date = formatter.date(from: dateString)
        return date
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return formatter.string(from: date)
        }
        
        return nil
    }
}
