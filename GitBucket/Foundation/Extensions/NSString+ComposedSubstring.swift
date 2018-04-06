//
//  NSString+ComposedSubstring.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/4/6.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation

extension NSString {
    func composedSubstring(of length: Int) -> String {
        if self.length <= length {
            return self as String
        }
        
        let range = NSRange(location: 0, length: length)
        let finalRange = rangeOfComposedCharacterSequences(for: range)
        return substring(with: finalRange) + "..."
    }
}
