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
        dateFormatter.dateFormat = "YYYY-MM-DD'T'HH:MM:SSZ" //All timestamps in Github API return in ISO 8601 format
        return dateFormatter
    }()
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        guard let dateString = value as? String else { return nil }
        
        return formatter.date(from: dateString)
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return formatter.string(from: date)
        }
        
        return nil
    }
}
