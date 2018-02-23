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
    }
    
    class func createInstance(forUser user: SGUser, userSourceType source: UserSource) -> SGUserListViewController {
        let instance = SGUserListViewController()
        instance.user = user
        instance.source = source
        return instance
    }
    
    var isMyself = false
    private var user: SGUser? = nil
    private var users: [SGUser] = []
    private var nextPage: Int? = 0
    private var source: UserSource = .followers
    private var isFetching = false
    
    private var viewTitle: String {
        let prefix = isMyself ? "我的" : user!.login! + "的"
        let suffix = .followers == source ? "粉丝" : "关注"
        return prefix + suffix
    }
    
    private typealias FetchUsersCompletionBlock = ([SGUser]?, Int?, Error?) -> Void
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewTitle
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SGUserListTableViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let profileVC = SGOtherProfileViewController(nibName: "SGBaseProfileViewController", bundle: nil)
        let userForCell = users[indexPath.row]
        profileVC.userName = userForCell.login
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let displayCell = cell as! SGUserListTableViewCell
        let user = users[indexPath.row]
        displayCell.user = user
        
        fetchFollowStatus(user, cell: displayCell)
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
        
        let mjfooter = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            self?.fetchUsers()
        })
        mjfooter?.isHidden = true
        tableView.mj_footer = mjfooter
    }
    
    func endRefresh() {
        tableView.mj_header.endRefreshing()
        if nil != nextPage {
            tableView.mj_footer.endRefreshing()
            tableView.mj_footer.isHidden = false
        }
        else {
            tableView.mj_footer.endRefreshingWithNoMoreData()
            tableView.mj_footer.isHidden = true
        }
    }
    
    //MARK: - Data Fetching
    func fetchUsers() {
        guard let user = user, let nextPage = nextPage else {return}
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
                strongSelf.view.makeToast(error?.localizedDescription)
            }
            
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            strongSelf.isFetching = false
            strongSelf.endRefresh()
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        isFetching = true
        if .followers == source {
            SGGithubClient.fetchFollowersForUser(user, page: nextPage, completion: completionBlock)
        }
        else {
            SGGithubClient.fetchFollowingsForUser(user, page: nextPage, completion: completionBlock)
        }
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
}
