//
//  SGConstant.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/1/27.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

enum SGAppColors: Int {
    case colorA14 = 0xfc3c39
    case colorA15 = 0xe8f6ef
    case colorA16 = 0x62c092
    case colorA17 = 0x168f54
    case colorA18 = 0x007b46
    
    case colorB0 = 0xffffff
    case colorB1 = 0xeeeeee
    case colorB2 = 0xC8C7CC
    case colorB3 = 0xbfbfbf
    case colorB4 = 0x959595
    case colorB5 = 0x707070
    case colorB6 = 0x000000
    case colorB7 = 0xe5e5e5
    case colorB8 = 0xf8f8f8
    case colorB9 = 0x434343
    
    case colorJ1 = 0xf15e4b
    case colorJ2 = 0xed2e66
    case colorJ3 = 0xffb430
    case colorJ4 = 0x2bb97d
    case colorJ5 = 0x30b8f3
    case colorJ6 = 0xe14828
    case colorJ7 = 0x8fcc0b
    
    case colorF1 = 0xd9403f
    case colorF2 = 0x47a9f0
    case colorF3 = 0x9cc551
    case colorF4 = 0x7d7d7d
    case colorF5 = 0xe14827
    case colorF6 = 0x39921a
    
    case colorT1a = 0xed5565
    case colorT2a = 0xfc8151
    case colorT3a = 0xf6bb48
    case colorT4a = 0xbcd85f
    case colorT5a = 0x83c06b
    case colorT6a = 0x48cfad
    case colorT7a = 0x4fc0e8
    case colorT8a = 0x5d9cec
    case colorT9a = 0xac92ec
    case colorT10a = 0xec87bf
    
    case colorT1b = 0xda4453
    case colorT2b = 0xe1602d
    case colorT3b = 0xf6ab42
    case colorT4b = 0x8cc152
    case colorT5b = 0x5ea044
    case colorT6b = 0x37bc9b
    case colorT7b = 0x3aafda
    case colorT8b = 0x4a89dc
    case colorT9b = 0x967adc
    case colorT10b = 0xd671ad
    
    case colorI1 = 0xBB0F23
    case colorI2 = 0x30434E
    case colorI3 = 0x4183C4
    case colorI4 = 0xe9dba5
    case colorI5 = 0x24AFFC
    case colorI6 = 0xEDEDED
    case colorI7 = 0xD9D9D9
    
    var color: UIColor {
        return UIColor(hex: self.rawValue)
    }
}
