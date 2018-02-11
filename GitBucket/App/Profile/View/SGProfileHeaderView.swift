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
    
    private var initialAvatarHeight: CGFloat = 0
    
    override func awakeFromNib() {
        blurEffectView.removeFromSuperview()
        bigAvatarImageView.addSubview(blurEffectView)
        
        avatarButton.layer.cornerRadius = avatarButton.width / 2
        avatarButton.layer.masksToBounds = true
        nameLabel.text = ""
        
        activityIndicator.isHidden = true
        actionButton.isHidden = true
        
        initialAvatarHeight = bigAvatarImageView.height
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
    
    var initialOffset: CGPoint = CGPoint.zero
    var contentOffset: CGPoint = CGPoint.zero {
        didSet {
            if initialOffset.equalTo(CGPoint.zero) {
                initialOffset = contentOffset
            }
            
            //根据offset的值，改变bigAvatarImageView的大小
            let offsetY = contentOffset.y
            if offsetY >= initialOffset.y {
                bigAvatarImageView.frame = CGRect(x: 0, y: 0, width: self.width, height: initialAvatarHeight)
                blurEffectView.alpha = 1
                avatarButton.alpha = 1
                nameLabel.alpha = 1
            }
            else {
                let newHeight = initialAvatarHeight - (offsetY - initialOffset.y)
                let newWidth = newHeight * (self.width / initialAvatarHeight)
                bigAvatarImageView.frame = CGRect(x: (self.width - newWidth) / 2, y: (offsetY - initialOffset.y), width: newWidth, height: newHeight)
                
                let progress = fmin(1, -(offsetY - initialOffset.y) / 150.0)
                let alpha = 1 - progress
                blurEffectView.alpha = alpha
                avatarButton.alpha = alpha
                nameLabel.alpha = alpha
            }
        }
    }
}
