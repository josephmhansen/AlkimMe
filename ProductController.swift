//
//  ProductController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/6/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation
import CoreData


class ProductController {
    
    static let sharedController = ProductController()
    
    let fetchedResultsController: NSFetchedResultsController<Product>
    
    
    
    init() {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        let prioritySortDescriptor = NSSortDescriptor(key: "priority", ascending: true)
        let haveSortDescriptor = NSSortDescriptor(key: "have", ascending: true)
        request.sortDescriptors = [haveSortDescriptor, prioritySortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "have", cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Error with the initial fetch of the fetchedResultsController, \(error.localizedDescription)")
        }
    }
    
    

    
    func isHaveValueChecked(product: Product) {
        product.have = !product.have
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        do {
            try CoreDataStack.context.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
    
}




