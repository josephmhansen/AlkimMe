//
//  SettingsController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/11/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation

class SettingsController {
    
    static let sharedController = SettingsController()
    
    // var launchedBefore: Bool = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    var firstLaunch: Bool = true
    
    func saveSettings() {
        UserDefaults.standard.set(firstLaunch, forKey: "firstLaunch")
    }
    
    func loadSettings() {
        
        guard let firstLaunch = UserDefaults.standard.object(forKey: "firstLaunch") as? Bool else { return }
        self.firstLaunch = firstLaunch
        
        
    }
    
    func loadFirstTime() {
        if firstLaunch == true {
            ProductController.sharedController.createAllProducts()
            firstLaunch = false
            
            saveSettings()
        }
    }
    
    
 /*    if launchedBefore = true {
    print("Not first launch.")
    }
    else {
    print("First launch, setting NSUserDefault.")
    UserDefaults.standard.bool(true, forKey: "launchedBefore")
    }
 */
}
