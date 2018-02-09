//
//  SGBaseProfileViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import MBProgressHUD

enum SGProfileCellID: Int {
    case company
    case location
    case email
    case blog
    case settings
    case name
    case stars
    case publicActivity
}

struct SGProfileCellData {
    let id: SGProfileCellID
    let icon: UIImage
    let text: String
    let rightArrow: Bool
    let rightText: String?
    
    init(id: SGProfileCellID, icon: UIImage, text: String, rightArrow: Bool, rightText: String? = nil) {
        self.id = id
        self.icon = icon
        self.text = text
        self.rightArrow = rightArrow
        self.rightText = rightText
    }
}

class SGBaseProfileViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {
    var userName: String?
    var user: SGUser? {
        didSet {
            buildCellDatas()
            tableView.reloadData()
        }
    }
    var cellDatas: [[SGProfileCellData]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.register(SGTableViewCellStyleValue1.self, forCellReuseIdentifier: SGTableViewCellStyleValue1.reuseIdentifier)
        fetchUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Fetch Data
    func fetchUserInfo() {
        if let name = userName {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            SGGithubClient.fetchUserInfo(for: name, completion: { user, error in
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if nil != user {
                    self.user = user
                }
                else if nil != error {
                    self.view.makeToast((error! as NSError).localizedDescription)
                }
            })
        }
        else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            SGGithubClient.fetchUserInfo(completion: { user, error in
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if nil != user {
                    self.user = user
                }
                else if nil != error {
                    self.view.makeToast((error! as NSError).localizedDescription)
                }
            })
        }
    }
    
    //MARK: - Functions for override
    func buildCellDatas() {
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SGTableViewCellStyleValue1.reuseIdentifier, for: indexPath)
        let cellData = cellDatas[indexPath.section][indexPath.row]
        cell.imageView?.image = cellData.icon
        cell.textLabel?.text = cellData.text
        if cellData.rightArrow {
            cell.accessoryType = .disclosureIndicator
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == cellDatas.count - 1 {
            return 20
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
}
