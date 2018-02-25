//
//  SGOtherProfileViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGOtherProfileViewController: SGBaseProfileViewController, SGProfileHeaderViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = userName
        headerView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func buildCellDatas() {
        if let user = self.user, cellDatas.isEmpty {
            let iconSize = CGSize(width: 25, height: 25)
            
            var section0 = [SGProfileCellData]()
            let nameIcon = UIImage.icon(with: "Person", color: UIColor(hex: 0x24AFFC), size: iconSize)
            section0.append(SGProfileCellData(id: .name, icon: nameIcon, text: "Name", rightArrow: false, rightText: user.displayName))
            
            let starIcon = UIImage.icon(with: "Star", color: SGAppColors.colorI3.color, size: iconSize)
            section0.append(SGProfileCellData(id: .stars, icon: starIcon, text: "Starred Repos", rightArrow: true))
            
            let rssIcon = UIImage.icon(with: "Rss", color: UIColor(hex: 0x4078c0), size: iconSize)
            section0.append(SGProfileCellData(id: .publicActivity, icon: rssIcon, text: "Public Activity", rightArrow: true))
            
            var section1 = [SGProfileCellData]()
            
            let bioIcon = UIImage.icon(with: "Comment", color: UIColor(hex: 0x24AFFC), size: iconSize)
            section1.append(SGProfileCellData(id: .bio, icon: bioIcon, text: user.displayBio, rightArrow: false))
            
            let hireIcon = UIImage.icon(with: "Info", color: UIColor(hex: 0x24AFFC), size: iconSize)
            section1.append(SGProfileCellData(id: .hireable, icon: hireIcon, text: user.displayHireable, rightArrow: false))
            
            let companyIcon = UIImage.icon(with: "Organization", color: UIColor(hex: 0x24AFFC), size: iconSize)
            section1.append(SGProfileCellData(id: .company, icon: companyIcon, text: user.displayCompany, rightArrow: false))
            
            let locationIcon = UIImage.icon(with: "Location", color: UIColor(hex: 0x30C931), size: iconSize)
            section1.append(SGProfileCellData(id: .location, icon: locationIcon, text: user.displayLocation, rightArrow: false))
            
            let mailIcon = UIImage.icon(with: "Mail", color: UIColor(hex: 0x5586ED), size: iconSize)
            section1.append(SGProfileCellData(id: .email, icon: mailIcon, text: user.displayEmail, rightArrow: false))
            
            let blogIcon = UIImage.icon(with: "Link", color: UIColor(hex: 0x90DD2F), size: iconSize)
            section1.append(SGProfileCellData(id: .blog, icon: blogIcon, text: user.displayBlog, rightArrow: false))
            
            cellDatas.append(section0)
            cellDatas.append(section1)
            
            fetchFollowStatus(user)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellData = cellDatas[indexPath.section][indexPath.row]
        switch cellData.id {
        case .stars:
            let reposVC = SGRepoListViewController.createInstance(for: self.user!, category: .starred)
            self.navigationController?.pushViewController(reposVC, animated: true)
            break
            
        case .publicActivity:
            break
            
        case .email:
            break
            
        case .blog:
            if let blog = user?.blog, let url = URL(string: blog) {
                UIApplication.shared.openURL(url)
            }
            break
            
        default:
            break
        }
    }
    
    func fetchFollowStatus(_ user: SGUser) {
        SGGithubClient.doesFollowUser(user) { [weak self] result, error in
            guard let strongSelf = self else {return}
            
            if nil == error {
                user.doesFollow = result
                strongSelf.headerView?.updateActionButtonDisplay()
            }
            else {
                print("SGOtherProfileViewController fetchFollowStatus error")
            }
        }
    }
    
    //MARK: - SGProfileHeaderViewDelegate
    func profileHeaderView(_ headerView: SGProfileHeaderView, didTouchFollowButton button: SGFollowButton) {
        button.isEnabled = false
        
        if button.isSelected {
            SGGithubClient.unfollowUser(self.user!, completion: { [weak self] result, error in
                guard let strongSelf = self else {return}
                button.isEnabled = true
                if nil != error {
                    strongSelf.view.showToast(error!.localizedDescription)
                }
                else {
                    button.isSelected = false
                }
            })
        }
        else {
            SGGithubClient.followUser(self.user!, completion: { [weak self] result, error in
                guard let strongSelf = self else {return}
                button.isEnabled = true
                if nil != error {
                    strongSelf.view.showToast(error!.localizedDescription)
                }
                else {
                    button.isSelected = true
                }
            })
        }
    }
}
