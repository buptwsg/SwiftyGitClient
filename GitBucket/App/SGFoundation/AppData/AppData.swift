//
//  AppData.swift
//  GitBucket
//
//  Created by sulirong on 2018/1/29.
//  Copyright © 2018年 CleanAirGames. All rights reserved.
//

import Foundation

class AppData: NSObject, NSCoding {
    var user: SGUser? = nil
    
    static let `default`: AppData = {
        let path = archivePath
        if FileManager.default.fileExists(atPath: path) {
            if let savedAppData = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? AppData {
                return savedAppData
            }
            else {
                return AppData()
            }
        }
        else {
            return AppData()
        }
    }()
    
    override init() {
    }
    
    func save() {
        let path = type(of: self).archivePath
        let result = NSKeyedArchiver.archiveRootObject(self, toFile: path)
        if !result {
            print("archive appdata failed")
        }
    }
    
    func isLoggedUser(_ anotherEntity: SGEntity) -> Bool {
        return user?.login == anotherEntity.login
    }
    
    //MARK: - NSCoding
    private static let archivePath: String = {
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docURL.appendingPathComponent("appdata.bin").path
    }()
    
    required init?(coder aDecoder: NSCoder) {
        if let userJSON = aDecoder.decodeObject(forKey: "user") as? String {
            user = SGUser(JSONString: userJSON)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        let json = self.user?.toJSONString(prettyPrint: true)
        aCoder.encode(json, forKey: "user")
    }
}
