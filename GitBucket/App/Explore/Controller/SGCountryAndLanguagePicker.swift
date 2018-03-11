//
//  SGCountryAndLanguagePicker.swift
//  GitBucket
//
//  Created by Shuguang Wang on 2018/3/11.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import UIKit

class SGCountryAndLanguagePicker: SGSegmentedControlViewController, SGPickerDelegate {
    var languagePicker: SGPickerViewController? = nil
    var countryPicker: SGPickerViewController? = nil
    var originCountryData: SGExploreData? = nil
    var originLanguageData: SGExploreData? = nil
    var notifyChangeBlock: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tapBackButton(_ button: UIButton) {
        if originLanguageData != AppData.default.languageDataOfPopularUsers || originCountryData != AppData.default.countryDataOfPopularUsers {
            AppData.default.save()
            if nil != notifyChangeBlock {
                notifyChangeBlock?()
            }
        }
        
        super.tapBackButton(button)
    }
    
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        originCountryData = AppData.default.countryDataOfPopularUsers
        originLanguageData = AppData.default.languageDataOfPopularUsers
        
        languagePicker = SGPickerViewController()
        languagePicker?.segmentedTitle = "Language"
        languagePicker?.resource = "Languages"
        languagePicker?.delegate = self
        languagePicker?.selectedData = originLanguageData
        
        countryPicker = SGPickerViewController()
        countryPicker?.segmentedTitle = "Country"
        countryPicker?.resource = "Countries"
        countryPicker?.delegate = self
        countryPicker?.selectedData = originCountryData
        
        self.viewControllers = [countryPicker!, languagePicker!]
    }
    
    func picker(_ picker: SGPickerViewController, didPickExploreData data: SGExploreData) {
        if picker == languagePicker {
            AppData.default.languageDataOfPopularUsers = data
        }
        else if picker == countryPicker {
            AppData.default.countryDataOfPopularUsers = data
        }
        else {
            
        }
    }
}
