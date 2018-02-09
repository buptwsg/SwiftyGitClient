//
//  SGProfileHeaderView.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/9.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import Kingfisher

class SGProfileHeaderView: UIView {
    @IBOutlet weak var bigAvatarImageView: UIImageView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var actionButton: SGFollowButton!
    
    override func awakeFromNib() {
        blurEffectView.removeFromSuperview()
        bigAvatarImageView.addSubview(blurEffectView)
        activityIndicator.isHidden = true
        actionButton.isHidden = true
    }
    
    var user: SGUser? {
        didSet {
            if let user = user {
                bigAvatarImageView.kf.setImage(with: user.avatarURL)
                followersLabel.text = String(user.followers)
                reposLabel.text = String(user.publicRepoCount)
                followingLabel.text = String(user.following)
                avatarButton.kf.setImage(with: user.avatarURL, for: .normal)
                nameLabel.text = user.displayName
            }
        }
    }
    
    var contentOffset: CGPoint = CGPoint.zero {
        didSet {
            
        }
    }
}
