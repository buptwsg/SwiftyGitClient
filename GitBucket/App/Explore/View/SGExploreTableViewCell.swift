//
//  SGExploreTableViewCell.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import Kingfisher

class SGExploreTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    static let identifier = "SGExploreTableViewCell"
    
    var dataArray: [Any] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        let nib = UINib(nibName: SGExploreCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SGExploreCollectionViewCell.identifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SGExploreCollectionViewCell.identifier, for: indexPath) as! SGExploreCollectionViewCell
        let data = dataArray[indexPath.item]
        if let repository = data as? SGRepository {
            cell.nameLabel.text = repository.name
            cell.avatarImageView.kf.setImage(with: repository.ownerAvatarURL)
        }
        else if let user = data as? SGUser {
            cell.nameLabel.text = user.displayName
            cell.avatarImageView.kf.setImage(with: user.avatarURL, placeholder: UIImage(named: "avatar_default"))
        }
        else {
            assert(false, "unrecognized object type in dataArray")
        }
        
        return cell
    }
}
