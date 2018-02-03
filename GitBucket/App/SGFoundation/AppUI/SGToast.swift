//
//  SGToast.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/2/3.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Toast_Swift

extension UIView {
    func makeToast(_ message: String) {
        makeToast(message, duration: ToastManager.shared.duration, position: .center)
    }
}
