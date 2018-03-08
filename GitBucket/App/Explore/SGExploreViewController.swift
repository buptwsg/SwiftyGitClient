//
//  SGExploreViewController.swift
//  GitBucket
//
//  Created by sulirong on 2018/3/8.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGExploreViewController: SGBaseTableViewController {

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    //MARK: - Table view delegate
}
