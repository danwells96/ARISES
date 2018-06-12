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
        static let reset = "reloadGlucosePreference"
    }
    
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.basalEnabled) {
            print("Basal showing")
        }//else if UserDefaults.standard.bool(forKey: SettingsBundleKeys.)
        else if(UserDefaults.standard.bool(forKey: SettingsBundleKeys.reset)){
            print("reset")
            //No function currently to delete from model controller
        }
    }
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_preference")
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_preference")
    }
}
