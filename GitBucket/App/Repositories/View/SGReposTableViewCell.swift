//
//  SGReposTableViewCell.swift
//  GitBucket
//
//  Created by shuguang on 2018/2/15.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

private var _repoIcon: UIImage? = nil
private var _repoForkedIcon: UIImage? = nil
private var _lockIcon: UIImage? = nil
private var _starIcon: UIImage? = nil
private var _gitBranchIcon: UIImage? = nil

class SGReposTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starIconImageView: UIImageView!
    @IBOutlet weak var startCountLabel: UILabel!
    @IBOutlet weak var forkIconImageView: UIImageView!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var layoutConstraint: NSLayoutConstraint!
    
    static let reuseIdentifier = "SGRepoCell"
    var repository: SGRepository? {
        didSet {
            nameLabel.text = repository?.name
            desLabel.text = repository?.repoDescription
            iconImageView.image = iconForRepo()
            languageLabel.text = repository?.language
            starIconImageView.image = _starIcon
            startCountLabel.text = String(describing: repository!.stargazersCount)
            forkIconImageView.image = _gitBranchIcon
            forkCountLabel.text = String(describing: repository!.forksCount)
            updateTimeLabel.text = repository?.dateUpdated?.distanceFromNow
            layoutConstraint.constant = languageLabel.text == nil ? 0 : 10
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if nil == _repoIcon {
            _repoIcon = UIImage.icon(with: "Repo", color: UIColor.darkGray, size: iconImageView.size)
            _repoForkedIcon = UIImage.icon(with: "RepoForked", color: UIColor.darkGray, size: iconImageView.size)
            _lockIcon = UIImage.icon(with: "Lock", color: SGAppColors.colorI4.color, size: iconImageView.size)
            _starIcon = UIImage.icon(with: "Star", color: UIColor.darkGray, size: starIconImageView.size)
            _gitBranchIcon = UIImage.icon(with: "GitBranch", color: UIColor.darkGray, size: forkIconImageView.size)
        }
    }
    
    func iconForRepo() -> UIImage? {
        if let repo = repository {
            if repo.isFork {
                return _repoForkedIcon
            }
            else if repo.isPrivate {
                return _lockIcon
            }
            else {
                return _repoIcon
            }
        }
        else {
            return nil
        }
    }
}
