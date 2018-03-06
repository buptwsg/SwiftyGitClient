//
//  SGBaseTableViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/6.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGBaseTableViewController: UITableViewController {
    deinit {
        showDeinitToast()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
