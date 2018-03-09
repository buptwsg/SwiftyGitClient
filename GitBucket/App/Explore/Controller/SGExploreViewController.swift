//
//  SGExploreViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import MBProgressHUD

class SGExploreViewController: SGBaseTableViewController {
    private var showcases: [SGShowCase] = []
    private var trendingRepositories: [SGRepository] = []
    private var popularRepositories: [SGRepository] = []
    private var popularUsers: [SGUser] = []
    private let dispatchGroup = DispatchGroup()
    private var cellTitles = [String]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAllData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UI
    private func setupUI() {
        tableView.tableFooterView = nil
        tableView.separatorStyle = .none
        tableView.rowHeight = 168
        let nib = UINib(nibName: SGExploreTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SGExploreTableViewCell.identifier)
    }
    
    //MARK: - Fetch Data
    private func fetchAllData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchShowcases()
        fetchTrendingRepositories()
        fetchPopularRepositories()
        fetchPopularUsers()
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.cellTitles = ["Trending repositories this week", "Popular repositories", "Popular users"]
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        }
    }
    
    private func fetchShowcases() {
        dispatchGroup.enter()
        SGGithubClient.fetchShowCases {[weak self] (responseShowcases, error) in
            guard let strongSelf = self else {return}
            strongSelf.dispatchGroup.leave()
            
            if let response = responseShowcases, nil == error {
                strongSelf.showcases = response
            }
            else {
                print("SGGithubClient.fetchShowCases error: \(error!.localizedDescription)")
            }
        }
    }
    
    private func fetchTrendingRepositories() {
        dispatchGroup.enter()
        SGGithubClient.fetchTrendingRepos(since: "weekly", language: "") {[weak self] (responseRepos, error) in
            guard let strongSelf = self else {return}
            strongSelf.dispatchGroup.leave()
            
            if let response = responseRepos, nil == error {
                strongSelf.trendingRepositories = response
            }
            else {
                print("SGGithubClient.fetchTrendingRepos error: \(error!.localizedDescription)")
            }
        }
    }
    
    private func fetchPopularRepositories() {
        dispatchGroup.enter()
        SGGithubClient.fetchPopularRepos(language: "") {[weak self] (responseRepos, error) in
            guard let strongSelf = self else {return}
            strongSelf.dispatchGroup.leave()
            
            if let response = responseRepos, nil == error {
                strongSelf.popularRepositories = response
            }
            else {
                print("SGGithubClient.fetchPopularRepos error: \(error!.localizedDescription)")
            }
        }
    }
    
    private func fetchPopularUsers() {
        dispatchGroup.enter()
        SGGithubClient.fetchPopularUsers(location: "", language: "") {[weak self] (responseUsers, error) in
            guard let strongSelf = self else {return}
            strongSelf.dispatchGroup.leave()
            
            if let response = responseUsers, nil == error {
                strongSelf.popularUsers = response
            }
            else {
                print("SGGithubClient.fetchPopularUsers error: \(error!.localizedDescription)")
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SGExploreTableViewCell.identifier, for: indexPath) as! SGExploreTableViewCell
        cell.titleLabel.text = cellTitles[indexPath.row]
        cell.seeAllButton.tag = indexPath.row
        cell.seeAllButton.removeTarget(self, action: #selector(seeAllData(button:)), for: .touchUpInside)
        cell.seeAllButton.addTarget(self, action: #selector(seeAllData(button:)), for: .touchUpInside)
        
        switch indexPath.row {
        case 0:
            cell.dataArray = trendingRepositories
            
        case 1:
            cell.dataArray = popularRepositories
            
        case 2:
            cell.dataArray = popularUsers
            
        default:
            break
        }
        
        return cell
    }
    
    //MARK: - Actions
    @objc
    func seeAllData(button: UIButton) {
        print("clicked button tag is \(button.tag)")
    }
}
