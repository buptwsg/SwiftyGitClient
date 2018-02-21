//
//  NSDate+Distance.swift
//  GitBucket
//
//  Created by shuguang on 2018/2/21.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation

extension Date {
    var distanceFromNow: String {
        let secondsPerMinute: TimeInterval = 60
        let secondsPerHour: TimeInterval = 60 * secondsPerMinute
        let secondsPerDay: TimeInterval = 24 * secondsPerHour
        let secondsPerMonth: TimeInterval = 30 * secondsPerDay
        let secondsPerYear: TimeInterval = 365 * secondsPerDay
        
        let seconds = Date().timeIntervalSince(self)
        if seconds < secondsPerMinute {
            return "刚刚"
        }
        else if seconds < secondsPerHour {
            return "\(Int(seconds / secondsPerMinute))分钟以前"
        }
        else if seconds < secondsPerDay {
            return "\(Int(seconds / secondsPerHour))小时以前"
        }
        else if seconds < secondsPerMonth {
            return "\(Int(seconds / secondsPerDay))天以前"
        }
        else if seconds < secondsPerYear {
            return "\(Int(seconds / secondsPerMonth))月以前"
        }
        else {
            return "\(Int(seconds / secondsPerYear))年以前"
        }
    }
}
