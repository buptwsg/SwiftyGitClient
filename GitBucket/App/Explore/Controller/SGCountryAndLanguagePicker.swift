//
//  SGCountryAndLanguagePicker.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGCountryAndLanguagePicker: SGSegmentedControlViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        let languagePicker = SGLanguagePickerViewController()
        languagePicker.segmentedTitle = "Language"
        let countryPicker = SGCountryPickerViewController()
        countryPicker.segmentedTitle = "Country"
        self.viewControllers = [countryPicker, languagePicker]
    }
}
