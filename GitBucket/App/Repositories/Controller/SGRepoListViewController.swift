//
//  SGRepoListViewController.swift
//  GitBucket
//
//  Created by shuguang on 2018/2/15.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import MJRefresh

class SGRepoListViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    enum RepoCategory: Int {
        case owned
        case starred
    }
    
    var entity: SGEntity?
    var reposArray = [SGRepository]()
    var nextPage: Int? = 0
    var isFetching = false
    typealias FetchReposCompletionBlock = ([SGRepository]?, Int?, Error?) -> Void
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewTitle
        setupTableView()
        
        fetchRepositories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Public
    class func createInstance(`for` entity: SGEntity, category: RepoCategory) -> SGRepoListViewController{
        var controller: SGRepoListViewController
        if RepoCategory.starred == category {
            controller = SGStarredReposViewController(nibName: "SGRepoListViewController", bundle: nil)
        }
        else {
            controller = SGOwnedReposViewController(nibName: "SGRepoListViewController", bundle: nil)
        }
        controller.entity = entity
        return controller
    }
    
    //MARK: - Data
    var viewTitle: String {
        return ""
    }
    
    func executeRequestWithCompletionBlock(completion: @escaping FetchReposCompletionBlock) {
    }
    
    private func fetchRepositories() {
        guard let _ = entity, let nextPage = nextPage else {return}
        
        if isFetching {
            return
        }
        
        let completionBlock: FetchReposCompletionBlock = { [weak self] (repos, returnedNextPage, error) in
            guard let strongSelf = self else {return}
            
            if nil == error {
                strongSelf.nextPage = returnedNextPage
                if 0 == nextPage {
                    strongSelf.reposArray.removeAll()
                }
                strongSelf.reposArray.append(contentsOf: repos!)
                strongSelf.tableView.reloadData()
            }
            else {
                strongSelf.view.makeToast(error?.localizedDescription)
            }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            strongSelf.isFetching = false
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        isFetching = true
        executeRequestWithCompletionBlock(completion: completionBlock)
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SGReposTableViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let repoCell = cell as! SGReposTableViewCell
        repoCell.repository = self.reposArray[indexPath.row]
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - private
    func setupTableView() {
        let cellNib = UINib(nibName: SGReposTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: SGReposTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 78
    }
}
