//
//  SGFollowButton.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/9.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGFollowButton: UIButton {
    static let normalImage: UIImage = UIImage.icon(with: "Person", color: UIColor.white, size: CGSize(width: 16, height: 16))
    static let selectedImage: UIImage = UIImage.icon(with: "Person", color: UIColor(hex: 0x333333), size: CGSize(width: 16, height: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        layer.borderUIColor = UIColor(hex: 0xd5d5d5)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        contentEdgeInsets = UIEdgeInsets(top: 7, left: 1, bottom: 7, right: 3)
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        
        set {
            super.isSelected = newValue
            
            if !isSelected {
                setImage(type(of: self).normalImage, for: .normal)
                setTitle("Follow", for: .normal)
                setTitleColor(UIColor.white, for: .normal)
                
                backgroundColor = UIColor(hex: 0x569e3d)
                layer.borderWidth = 0
            }
            else {
                setImage(type(of: self).selectedImage, for: .normal)
                setTitle("Unfollow", for: .normal)
                setTitleColor(UIColor(hex: 0x333333), for: .normal)
                
                backgroundColor = UIColor(hex: 0xeeeeee)
                layer.borderWidth = 1
            }
        }
    }
}
