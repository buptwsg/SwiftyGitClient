//
//  SGSettingsViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/2/10.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import Kingfisher

private struct SGSettingsCellData {
    let reuseIdentifier: String
    let text: String
    var rightText: String?
    let accessoryType: UITableViewCellAccessoryType
    let selectionStyle: UITableViewCellSelectionStyle
}

class SGSettingsViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {
    var user: SGUser?
    private var cellsData: [[SGSettingsCellData]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        buildCellData()
        tableView.register(SGTableViewCellStyleValue1.self, forCellReuseIdentifier: SGStyleValue1ReuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SGStyleDefaultReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellsData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = cellsData[indexPath.section][indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellData.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = cellData.text
        cell.detailTextLabel?.text = cellData.rightText
        cell.accessoryType = cellData.accessoryType
        cell.selectionStyle = cellData.selectionStyle
        
        if indexPath.section == cellsData.count - 1 {
            cell.textLabel?.textAlignment = .center
        }
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (0 == section) ? 20 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (tableView.numberOfSections - 1 == section) ? 20 : 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.cellForRow(at: indexPath)
                cell?.detailTextLabel?.isHidden = true
                let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                cell?.accessoryView = indicator
                indicator.startAnimating()
                
                ImageCache.default.clearDiskCache(completion: {
                    indicator.stopAnimating()
                    cell?.accessoryView = nil
                    cell?.detailTextLabel?.isHidden = false
                    self.updateCacheSizeText("0.0MB")
                })
                break
                
            case 1:
                let aboutVC = SGAboutViewController()
                navigationController?.pushViewController(aboutVC, animated: true)
                
            default:
                break
            }
            
        case 2:
            SGGithubOAuth.default.clearAccessToken()
            let rootVC = SGLoginViewController.instance
            self.view.window?.rootViewController = rootVC

        default:
            break
        }
    }
    
    //MARK: - private
    func buildCellData() {
        let accountData = SGSettingsCellData(reuseIdentifier: SGStyleValue1ReuseIdentifier, text: "My Account", rightText: user!.login, accessoryType: .none, selectionStyle: .none)
        let cacheData = SGSettingsCellData(reuseIdentifier: SGStyleValue1ReuseIdentifier, text: "清理缓存", rightText: "0.0MB", accessoryType: .none, selectionStyle: .default)
        let aboutData = SGSettingsCellData(reuseIdentifier: SGStyleDefaultReuseIdentifier, text: "About", rightText: nil, accessoryType: .disclosureIndicator, selectionStyle: .default)
        let logoutData = SGSettingsCellData(reuseIdentifier: SGStyleDefaultReuseIdentifier, text: "Logout", rightText: nil, accessoryType: .none, selectionStyle: .default)
        
        cellsData = [[accountData], [cacheData, aboutData], [logoutData]]
        
        ImageCache.default.calculateDiskCacheSize { sizeInbytes in
            let mb = 1.0 * Double(sizeInbytes) / (1024.0 * 1024.0)
            self.updateCacheSizeText(String(format: "%.2fMB", mb))
        }
    }
    
    func updateCacheSizeText(_ text: String) {
        self.cellsData[1][0].rightText = text
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
    }
}
