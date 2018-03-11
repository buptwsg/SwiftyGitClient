//
//  SGPickerViewController.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

protocol SGPickerDelegate: NSObjectProtocol {
    func picker(_ picker: SGPickerViewController, didPickExploreData data: SGExploreData)
}

class SGPickerViewController: SGBaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: SGPickerDelegate? = nil
    var resource: String = ""
    var navTitle: String = ""
    var selectedData: SGExploreData? = nil
    
    private var allData: [SGExploreData] = []
    private var sectionIndexTitles: [String] = []
    private var dataBySection: [[SGExploreData]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        title = segmentedTitle
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SGStyleDefaultReuseIdentifier)
        
        allData = exploreDataFromResouce(resource)
        for data in allData {
            let indexString = data.name.prefix(1).uppercased()
            if sectionIndexTitles.isEmpty || indexString != sectionIndexTitles.last {
                sectionIndexTitles.append(indexString)
                dataBySection.append([data])
            }
            else {
                dataBySection[dataBySection.count - 1].append(data)
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
        return dataBySection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataBySection[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SGStyleDefaultReuseIdentifier, for: indexPath)
        cell.textLabel?.text = dataBySection[indexPath.section][indexPath.row].name
        if (cell.textLabel?.text == selectedData?.name) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = dataBySection[indexPath.section][indexPath.row]
        selectedData = data
        if nil != self.delegate {
            self.delegate?.picker(self, didPickExploreData: data)
        }
        tableView.reloadData()
    }
}
