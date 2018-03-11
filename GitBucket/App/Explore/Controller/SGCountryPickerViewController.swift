//
//  SGCountryPickerViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGCountryPickerViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var allCountries: [SGExploreData] = []
    private var sectionIndexTitles: [String] = []
    private var countriesBySection: [[SGExploreData]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        title = "Country"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SGStyleDefaultReuseIdentifier)
        
        allCountries = exploreDataFromResouce("Countries")
        for data in allCountries {
            let indexString = data.name.prefix(1).uppercased()
            if sectionIndexTitles.isEmpty || indexString != sectionIndexTitles.last {
                sectionIndexTitles.append(indexString)
                countriesBySection.append([data])
            }
            else {
                countriesBySection[countriesBySection.count - 1].append(data)
            }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.contentInset = parent!.contentInset
        tableView.contentOffset = CGPoint(x: 0, y: -tableView.contentInset.top)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return countriesBySection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesBySection[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SGStyleDefaultReuseIdentifier, for: indexPath)
        cell.textLabel?.text = countriesBySection[indexPath.section][indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionIndexTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    //MARK: - Table view delegate
}
