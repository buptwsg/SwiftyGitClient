//
//  SGSelfProfileViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGSelfProfileViewController: SGBaseProfileViewController {
    
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
            
            var section1 = [SGProfileCellData]()
            let companyIcon = UIImage.icon(with: "Organization", color: UIColor(hex: 0x24AFFC), size: iconSize)
            section1.append(SGProfileCellData(id: .company, icon: companyIcon, text: user.company ?? "Not Set", rightArrow: true))
            
            let locationIcon = UIImage.icon(with: "Location", color: UIColor(hex: 0x30C931), size: iconSize)
            section1.append(SGProfileCellData(id: .location, icon: locationIcon, text: user.location ?? "Not Set", rightArrow: true))
            
            let mailIcon = UIImage.icon(with: "Mail", color: UIColor(hex: 0x5586ED), size: iconSize)
            section1.append(SGProfileCellData(id: .email, icon: mailIcon, text: user.email ?? "Not Set", rightArrow: true))
            
            let blogIcon = UIImage.icon(with: "Link", color: UIColor(hex: 0x90DD2F), size: iconSize)
            section1.append(SGProfileCellData(id: .blog, icon: blogIcon, text: user.blog ?? "Not Set", rightArrow: true))
            
            var section2 = [SGProfileCellData]()
            let settingIcon = UIImage.icon(with: "Gear", color: UIColor(hex: 0x24AFFC), size: iconSize)
            section2.append(SGProfileCellData(id: .settings, icon: settingIcon, text: "Settings", rightArrow: true))
            
            cellDatas.append(section1)
            cellDatas.append(section2)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellData = cellDatas[indexPath.section][indexPath.row]
        switch cellData.id {
        case .company, .location, .email, .blog:
            print("edit these property")
            
        case .settings:
            let settingsVC = SGSettingsViewController()
            settingsVC.user = user
            navigationController?.pushViewController(settingsVC, animated: true)
            
        default:
            break
        }
    }
}
