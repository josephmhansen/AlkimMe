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
    
//    let fetchedResultsController: NSFetchedResultsController<AnyObject>
    
    
    
    var products: [Product] {
        
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptor1 = NSSortDescriptor(key: "priority", ascending: false)
        let sortDescriptor2 = NSSortDescriptor(key: "have", ascending: false)
        
        request.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        
        
        let products = try? CoreDataStack.context.fetch(request) as [Product]
        
        return products ?? []
        
        //        let moc = CoreDataStack.context
        //        do {
        //            let result = try moc.fetch(request)
        //            return result
        //        } catch {
        //            return []
        //        }
        
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
        
        print(data)
        print(json)
        
        let products = productDictionaries.flatMap { Product(dictionary: $0) }
        completion(products)
    }
    
    
    
    
    func createAllProducts() {
        print(products)
        
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


