//
//  SGAboutViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGAboutViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    static let instance = {
        return SGAboutViewController()
    }()
    
    let cellTitles = ["Rate GitBucket", "Source Code", "Author", "Feedback"]
    let headerView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 114))
        view.autoresizingMask = .flexibleWidth
        view.backgroundColor = UIColor.clear
        
        let imageView = UIImageView(image: UIImage(named: "Icon-60"))
        view.addSubview(imageView)
        _ = imageView.snapHCenter.and.snapTop(20)
        
        let label = UILabel()
        label.textColor = UIColor(hex: 0x555555)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        view.addSubview(label)
        
        let name = Bundle.main.infoDictionary?["CFBundleName"] as! String
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        label.text = "\(name) v\(version)(\(build))"
        label.sizeToFit()
        _ = label.snapBottom(6).and.snapHCenter
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = cellTitles[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
