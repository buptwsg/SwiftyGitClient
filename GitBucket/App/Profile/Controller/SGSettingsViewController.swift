//
//  SGSettingsViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/2/10.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGSettingsViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {
    var user: SGUser?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "My Account"
            cell.detailTextLabel?.text = user!.login
            cell.accessoryType = .none
            
        case 1:
            cell.textLabel?.text = "About"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
            
        case 2:
            cell.textLabel?.text = "Logout"
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
            
        default:
            break
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
}
