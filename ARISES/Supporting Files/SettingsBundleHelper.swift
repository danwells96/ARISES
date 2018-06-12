//
//  SettingsBundleHelper.swift
//  ARISES
//
//  Created by Xiaoyu Ma on 12/06/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation

class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let basalEnabled = "showBasalPreference"
    }
    
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.basalEnabled) {
            //UserDefaults.standard.set(false, forKey: SettingsBundleKeys.Reset)
            //let appDomain: String? = Bundle.main.bundleIdentifier
            //UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            print("D \(UserDefaults.standard.bool(forKey: "showBasalPreference"))")
            // reset userDefaults..
            // CoreDataDataModel().deleteAllData()
            // delete all other user data here..
        }
    }
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_preference")
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_preference")
    }
}
