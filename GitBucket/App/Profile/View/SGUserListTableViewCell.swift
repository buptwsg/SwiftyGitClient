//
//  SGUserListTableViewCell.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import Kingfisher

class SGUserListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var htmlLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var operationButton: SGFollowButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    static let reuseIdentifier = "SGUserListTableViewCell"
    
    var user: SGUser? = nil {
        didSet {
            if let user = user {
                avatarImageView.kf.setImage(with: user.avatarURL, placeholder: UIImage(named: "avatar_default"))
                htmlLabel.text = user.htmlURL?.absoluteString
                loginLabel.text = user.login
                updateFollowStatus()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.layer.cornerRadius = avatarImageView.width / 2
        avatarImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateFollowStatus(forUser updatedUser: SGUser? = nil) {
        guard let user = user else {
            return
        }
        
        if nil != updatedUser && user.login != updatedUser!.login {
            return
        }
        
        operationButton.isSelected = user.doesFollow ?? false
        if nil == user.doesFollow {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
            operationButton.isHidden = true
        }
        else {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
            operationButton.isHidden = false
        }
    }
}
