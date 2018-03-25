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
    
    private var resultsController: SGSearchReposResultViewController?
    private var searchController: UISearchController?
    private var searchBar: UISearchBar!
    private var switchLanguageButton: UIButton?
    private var placeholder: String {
        return "Search for \(AppData.default.languageDataOfSearch!.name)"
    }
    
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
        //table view
        tableView.tableFooterView = nil
        tableView.separatorStyle = .none
        tableView.rowHeight = 168
        let nib = UINib(nibName: SGExploreTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SGExploreTableViewCell.identifier)
        
        //search controller
        definesPresentationContext = true
        
        resultsController = SGSearchReposResultViewController(nibName: "SGRepoListViewController", bundle: nil)
        searchController = UISearchController(searchResultsController: resultsController)
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = true
        
        searchBar = searchController?.searchBar
        searchBar?.placeholder = placeholder
        searchBar.showsCancelButton = false
        searchBar?.delegate = self
        navigationItem.titleView = searchBar
        
        switchLanguageButton = UIButton(type: .custom)
        switchLanguageButton?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        switchLanguageButton?.backgroundColor = UIColor.white
        switchLanguageButton?.setImage(UIImage.icon(with: "TriangleDown", color: UIColor.darkGray, size: CGSize(width: 20, height: 20)), for: .normal)
        switchLanguageButton?.addTarget(self, action: #selector(changeLanguageSetting), for: .touchUpInside)
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
        SGGithubClient.fetchPopularRepos(language: "") {[weak self] (responseRepos, nextPage, error) in
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
        SGGithubClient.fetchPopularUsers(location: "", language: "") {[weak self] (responseUsers, nextPage, error) in
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
        if (2 == button.tag) {
            let popularUsersVC = SGUserListViewController.createInstance(forUser: nil, userSourceType: .popular, supportPullUpRefresh: false)
            navigationController?.pushViewController(popularUsersVC, animated: true)
        }
        else if (1 == button.tag) {
            let popularReposVC = SGRepoListViewController.createInstance(for: nil, category: .popular)
            navigationController?.pushViewController(popularReposVC, animated: true)
        }
        else {
            let trendingReposVC = SGTrendingReposViewController()
            navigationController?.pushViewController(trendingReposVC, animated: true)
        }
    }
    
    @objc
    func changeLanguageSetting() {
        let languagePicker = SGPickerViewController()
        languagePicker.segmentedTitle = "Language"
        languagePicker.resource = "Languages"
        languagePicker.delegate = self
        languagePicker.selectedData = AppData.default.languageDataOfSearch
        languagePicker.manualAdjustInset = false
        
        navigationController?.pushViewController(languagePicker, animated: true)
    }
}

extension SGExploreViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let imageView = searchBar.searchIconView
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(switchLanguageButton!)
        switchLanguageButton?.center = CGPoint(x: imageView.width / 2, y: imageView.height / 2)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        switchLanguageButton?.removeFromSuperview()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text, !text.isEmpty {
            resultsController?.keyword = text
            resultsController?.language = AppData.default.languageDataOfSearch!.slug
            resultsController?.refreshRepositories()
        }
    }
}

extension SGExploreViewController : SGPickerDelegate {
    func picker(_ picker: SGPickerViewController, didPickExploreData data: SGExploreData) {
        if AppData.default.languageDataOfSearch != data {
            AppData.default.languageDataOfSearch = data
            AppData.default.save()
            searchBar.placeholder = placeholder
        }
    }
}
