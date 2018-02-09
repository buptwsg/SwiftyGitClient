//
//  SGOtherProfileViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGOtherProfileViewController: SGBaseProfileViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func buildCellDatas() {
        if let user = self.user {
            let iconSize = CGSize(width: 25, height: 25)
            
            var section0 = [SGProfileCellData]()
            let nameIcon = UIImage.icon(with: "Person", color: UIColor(hex: 0x24AFFC), size: iconSize)
            section0.append(SGProfileCellData(id: .name, icon: nameIcon, text: "Name", rightArrow: false, rightText: user.displayName))
            
            let starIcon = UIImage.icon(with: "Star", color: SGAppColors.colorI3.color, size: iconSize)
            section0.append(SGProfileCellData(id: .stars, icon: starIcon, text: "Starred Repos", rightArrow: true))
            
            let rssIcon = UIImage.icon(with: "Rss", color: UIColor(hex: 0x4078c0), size: iconSize)
            section0.append(SGProfileCellData(id: .publicActivity, icon: rssIcon, text: "Public Activity", rightArrow: true))
            
            var section1 = [SGProfileCellData]()
            let companyIcon = UIImage.icon(with: "Organization", color: UIColor(hex: 0x24AFFC), size: iconSize)
            section1.append(SGProfileCellData(id: .company, icon: companyIcon, text: user.company ?? "Not Set", rightArrow: true))
            
            let locationIcon = UIImage.icon(with: "Location", color: UIColor(hex: 0x30C931), size: iconSize)
            section1.append(SGProfileCellData(id: .location, icon: locationIcon, text: user.location ?? "Not Set", rightArrow: true))
            
            let mailIcon = UIImage.icon(with: "Mail", color: UIColor(hex: 0x5586ED), size: iconSize)
            section1.append(SGProfileCellData(id: .email, icon: mailIcon, text: user.email ?? "Not Set", rightArrow: true))
            
            let blogIcon = UIImage.icon(with: "Link", color: UIColor(hex: 0x90DD2F), size: iconSize)
            section1.append(SGProfileCellData(id: .blog, icon: blogIcon, text: user.blog ?? "Not Set", rightArrow: true))
            
            cellDatas.append(section0)
            cellDatas.append(section1)
        }
    }
}
