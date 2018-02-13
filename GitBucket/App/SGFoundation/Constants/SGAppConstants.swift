//
//  SGDeviceInfo.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kPhysicalScreenWidth = fmin(kScreenWidth, kScreenHeight)
let kPhysicalScreenHeight = fmax(kScreenWidth, kScreenHeight)

let SGStyleValue1ReuseIdentifier = SGTableViewCellStyleValue1.reuseIdentifier
let SGStyleDefaultReuseIdentifier = "UITableViewCell"
