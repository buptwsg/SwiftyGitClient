//
//  SGUserListViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/2/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit
import MBProgressHUD

class SGUserListViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    enum UserSource: Int {
        case followers
        case followings
    }
    
    class func createInstance(forUser user: SGUser!, userSourceType source: UserSource) -> SGUserListViewController {
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
    private var viewTitle: String {
        let prefix = isMyself ? "我的" : user!.login! + "的"
        let suffix = .followers == source ? "粉丝" : "关注"
        return prefix + suffix
    }
    
    private typealias FetchUsersCompletionBlock = ([SGUser]?, Int?, Error?) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewTitle
        
        let cellNib = UINib(nibName: SGUserListTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: SGUserListTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        fetchFirstPageOfUsers()
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
        
        fetchFollowStatus(user, indexPath: indexPath)
    }
    
    //MARK: - private
    func fetchFirstPageOfUsers() {
        guard let user = user else {return}

        let completionBlock: FetchUsersCompletionBlock = {[weak self] usersArray, nextPage, error in
            guard let strongSelf = self else {
                return
            }
            
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            if nil == error {
                strongSelf.nextPage = nextPage
                strongSelf.users.removeAll()
                strongSelf.users.append(contentsOf: usersArray!)
                strongSelf.tableView.reloadData()
            }
            else {
                strongSelf.view.makeToast(error?.localizedDescription)
            }
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if .followers == source {
            SGGithubClient.fetchFollowersForUser(user, page: nextPage!, completion: completionBlock)
        }
        else {
            SGGithubClient.fetchFollowingsForUser(user, page: nextPage!, completion: completionBlock)
        }
    }
    
    func fetchFollowStatus(_ user: SGUser, indexPath: IndexPath) {
        if nil != user.doesFollow {
            print("user's doesFollow has been assigned")
            return
        }
        
        weak var weakUser = user
        SGGithubClient.doesFollowUser(user) { [weak self] (result, error) in
            guard let strongUser = weakUser, let strongSelf = self else {
                print("response is late, user is deallocated")
                return
            }
            
            if nil != error {
                print("doesFollowUser returned error: \(error!.localizedDescription)")
            }
            else {
                strongUser.doesFollow = result
                //需要判断之前对应的indexPath，这时还是不是visible
                if let _ = strongSelf.tableView.indexPathsForVisibleRows?.contains(indexPath) {
                    print("the indexPath is still visible, update it")
                    strongSelf.tableView.beginUpdates()
                    strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                    strongSelf.tableView.endUpdates()
                }
                else {
                    print("indexPath : \(indexPath) is already not visible")
                }
            }
        }
    }
}
