//
//  SettingsBundleHelper.swift
//  ARISES
//
//  Created by Xiaoyu Ma on 12/06/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation

/**
	Handler class to detect and store any changes made to the app's preference list in Settings.
*/
class SettingsBundleHelper {

	/// Structure to store key names for the preference list so that settings can be accessed in other classes.
    struct SettingsBundleKeys {
        static let basalEnabled = "showBasalPreference"
        static let reset = "reloadGlucosePreference"
    }
    
	/// Function to implement any changes that don't need to be processed in the viewControllers.
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.basalEnabled) {
            print("Basal showing")
        }//else if UserDefaults.standard.bool(forKey: SettingsBundleKeys.)
        else if(UserDefaults.standard.bool(forKey: SettingsBundleKeys.reset)){
            print("reset")
            //No function currently to delete from model controller
        }
    }
    
	/// Function to set the app version in settings.
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_preference")
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_preference")
    }
}
