//
//  CoreDataStack.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/6/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: "AlkimMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error loading persistent stores: \(error)")
            }
        })
        return container
    }()
    static var context: NSManagedObjectContext { return container.viewContext }
    
}
