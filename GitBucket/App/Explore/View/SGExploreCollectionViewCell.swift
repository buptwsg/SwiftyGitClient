//
//  SGExploreCollectionViewCell.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGExploreCollectionViewCell: UICollectionViewCell {
    static let identifier = "SGExploreCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.layer.masksToBounds = true
    }
}
