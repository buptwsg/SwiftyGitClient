//
//  SGAllReposViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/4.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import MBProgressHUD

class SGAllReposViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    enum RepoCategory: Int {
        case owned
        case starred
    }
    
    var category: RepoCategory = RepoCategory.owned
    var allRepos: [SGRepository] = []
    var nextPage: Int? = 0
    var indexTitles: [String] = []
    var reposBySection: [[SGRepository]] = []
    
    typealias FetchReposCompletionBlock = ([SGRepository]?, Int?, Error?) -> Void
    
    class func allReposViewController(category: RepoCategory) -> SGAllReposViewController {
        let vc = SGAllReposViewController()
        vc.category = category
        return vc
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            self.fetchAllRepositories()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let topInset = parent!.topLayoutGuide.length
        let bottomInset = parent!.bottomLayoutGuide.length
        let contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0)
        tableView.contentInset = contentInset
        tableView.contentOffset = CGPoint(x: 0, y: -tableView.contentInset.top)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UI
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        let cellNib = UINib(nibName: SGReposTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: SGReposTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 83
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.sectionIndexColor = UIColor.darkGray
        
        tableView.tableHeaderView = nil
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        tableView.tableHeaderView = header
        header.addSubview(searchBar)
        
        searchBar.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resignSearchBar))
        tableView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Fetch All Repos
    func fetchAllRepositories() {
        let completionBlock: FetchReposCompletionBlock = {repos, returnedNextPage, error in
            if nil == error {
                self.allRepos.append(contentsOf: repos!)
                self.nextPage = returnedNextPage
                if nil != self.nextPage {
                    self.fetchAllRepositories()
                }
                else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.processDataAndUpdateUI()
                }
            }
            else {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.showToast(error!.localizedDescription)
                self.processDataAndUpdateUI()
            }
        }
        
        if category == .owned {
            SGGithubClient.fetchRepositories(page: nextPage!, completion: completionBlock)
        }
        else {
            SGGithubClient.fetchStarredRepositories(page: nextPage!, completion: completionBlock)
        }
    }
    
    func processDataAndUpdateUI() {
        if allRepos.count > 0 {
            var tempDict: [String : [SGRepository]] = [:]
            for repo in allRepos {
                let key = String(repo.name.prefix(1)).uppercased()
                
                var reposArray = tempDict[key]
                if nil == reposArray {
                    reposArray = [repo]
                    tempDict[key] = reposArray
                }
                else {
                    tempDict[key]?.append(repo)
                }
            }
            
            indexTitles = Array(tempDict.keys).map{title in
                return title.uppercased()
            }
            indexTitles.sort()
            for title in indexTitles {
                reposBySection.append(tempDict[title]!)
            }
            tableView.reloadData()
        }
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return reposBySection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposBySection[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SGReposTableViewCell.reuseIdentifier, for: indexPath) as! SGReposTableViewCell
        cell.repository = reposBySection[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if category == .starred {
            return [UITableViewIndexSearch] + indexTitles
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if 0 == index {
            tableView.scrollRectToVisible(tableView.tableHeaderView!.frame, animated: true)
            return -1
        }
        else {
            return index - 1
        }
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.allowsSelection = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.allowsSelection = true
    }
    
    @objc
    func resignSearchBar() {
        if (searchBar.isFirstResponder) {
            searchBar.resignFirstResponder()
            tableView.allowsSelection = true
        }
    }
}
