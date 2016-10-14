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
    
    var launchedBefore: Bool = UserDefaults.standard.bool(forKey: "launchedBefore")
    
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
            createAllProducts()
            firstLaunch = false
            
            saveSettings()
        }
    }
    
    
    func serializeJSON(_ completion: (_ products: [Product]) -> Void) {
        let filePath = Bundle.main.path(forResource: "alkimme", ofType: "json")!
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonDictionary = json as? [String:AnyObject],
            let productDictionaries = jsonDictionary["products"] as? [[String:AnyObject]] else {
                print("Unable to serialize JSON.")
                return
        }
        
        let products = productDictionaries.flatMap { Product(dictionary: $0) }
        completion(products)
        
        ProductController.sharedController.saveToPersistentStorage()
        
    }
    
    
    
    
    func createAllProducts() {
        
        serializeJSON { (products) in
            for product in products {
                _ = product
                ProductController.sharedController.saveToPersistentStorage()
                
            }
        }
    }
    
    
//    if launchedBefore = true {
//    print("Not first launch.")
//    }
//    else {
//    print("First launch, setting NSUserDefault.")
//    UserDefaults.standard.bool(true, forKey: "launchedBefore")
//    }
 
}
