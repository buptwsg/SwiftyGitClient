//
//  SGUserListViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh

class SGUserListViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    enum UserSource: Int {
        case followers
        case followings
        case popular
    }
    
    class func createInstance(forUser user: SGUser?, userSourceType source: UserSource, supportPullUpRefresh: Bool = true) -> SGUserListViewController {
        var instance: SGUserListViewController
        let nibName = "SGUserListViewController"
        switch source {
        case .followings:
            instance = SGFollowingsViewController(nibName: nibName, bundle: nil)
            
        case .followers:
            instance = SGFollowersViewController(nibName: nibName, bundle: nil)
            
        case .popular:
            instance = SGPopularUsersViewController(nibName: nibName, bundle: nil)
        }
        
        instance.user = user
        instance.pullUpToRefresh = supportPullUpRefresh
        return instance
    }
    
    var pullUpToRefresh = true
    var user: SGUser? = nil
    private var users: [SGUser] = []
    var nextPage: Int? = 0
    private var isFetching = false
    
    typealias FetchUsersCompletionBlock = ([SGUser]?, Int?, Error?) -> Void
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        fetchUsers()
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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SGUserListTableViewCell.reuseIdentifier, for: indexPath) as! SGUserListTableViewCell
        let user = users[indexPath.row]
        cell.user = user
        cell.actionHandler = {[weak self] button in
            self?.changeFollowStatus(button)
        }
        fetchFollowStatus(user, cell: cell)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let profileVC = SGOtherProfileViewController.createInstance()
        let userForCell = users[indexPath.row]
        profileVC.userName = userForCell.login
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    //MARK: - UI
    func setupTableView() {
        let cellNib = UINib(nibName: SGUserListTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: SGUserListTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        let mjheader = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.nextPage = 0
            self?.fetchUsers()
        })
        mjheader?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = mjheader
        
        if (pullUpToRefresh) {
            let mjfooter = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
                self?.fetchUsers()
            })
            mjfooter?.isHidden = true
            tableView.mj_footer = mjfooter
        }
    }
    
    func endRefresh() {
        tableView.mj_header.endRefreshing()
        
        if (pullUpToRefresh) {
            tableView.mj_footer.isHidden = false
            
            if nil != nextPage {
                tableView.mj_footer.endRefreshing()
            }
            else {
                tableView.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
    
    //MARK: - Data Fetching
    func fetchUsers() {
        guard let nextPage = nextPage else {return}
        if isFetching {
            return
        }
        
        let completionBlock: FetchUsersCompletionBlock = {[weak self] usersArray, returnedNextPage, error in
            guard let strongSelf = self else {
                return
            }
            
            if nil == error {
                strongSelf.nextPage = returnedNextPage
                if 0 == nextPage {
                    strongSelf.users.removeAll()
                }
                strongSelf.users.append(contentsOf: usersArray!)
                strongSelf.tableView.reloadData()
            }
            else {
                strongSelf.view.showToast(error!.localizedDescription)
            }
            
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            strongSelf.isFetching = false
            strongSelf.endRefresh()
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        isFetching = true
        executeRequestWithCompletionBlock(completion: completionBlock)
    }
    
    func executeRequestWithCompletionBlock(completion: @escaping FetchUsersCompletionBlock) {
        
    }
    
    func fetchFollowStatus(_ user: SGUser, cell: SGUserListTableViewCell) {
        if nil != user.doesFollow {
            print("user's doesFollow has been assigned")
            return
        }
        
        weak var weakUser = user
        SGGithubClient.doesFollowUser(user) { (result, error) in
            guard let strongUser = weakUser else {
                print("response is late, user is deallocated")
                return
            }
            
            if nil != error {
                print("doesFollowUser returned error: \(error!.localizedDescription)")
            }
            else {
                strongUser.doesFollow = result
                cell.updateFollowStatus(forUser: strongUser)
            }
        }
    }
    
    func changeFollowStatus(_ button: SGFollowButton) {
        guard let user = self.user else {return}
        
        button.isEnabled = false
        
        if button.isSelected {
            SGGithubClient.unfollowUser(user, completion: { [weak self] result, error in
                guard let strongSelf = self else {return}
                button.isEnabled = true
                if nil != error {
                    strongSelf.view.showToast(error!.localizedDescription)
                }
                else {
                    button.isSelected = false
                }
            })
        }
        else {
            SGGithubClient.followUser(user, completion: { [weak self] result, error in
                guard let strongSelf = self else {return}
                button.isEnabled = true
                if nil != error {
                    strongSelf.view.showToast(error!.localizedDescription)
                }
                else {
                    button.isSelected = true
                }
            })
        }
    }
}
