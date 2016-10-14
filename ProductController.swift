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
    
    
//    let prioritySortDescriptor = NSSortDescriptor(key: "priority", ascending: true)
//    let haveSortDescriptor = NSSortDescriptor(key: "have", ascending: true)
    
//    var products: [Product] {
//        let request: NSFetchRequest<Product> = Product.fetchRequest()
//        request.sortDescriptors = [prioritySortDescriptor, haveSortDescriptor]
//        
//        let moc = CoreDataStack.context
//                do {
//                    let result = try moc.fetch(request)
//                    return result
//                } catch {
//                    return []
//                }
//    }
    
//    var sortedProducts: [[Product]] {
//        var productsUserHas: [Product] = []
//        var productsUserNeeds: [Product] = []
//        
//        for product in products {
//            if product.have == true {
//                productsUserHas.append(product)
//            } else {
//                productsUserNeeds.append(product)
//            }
//        }
//        print(productsUserHas.count)
//        print(productsUserNeeds.count)
//        return [productsUserHas, productsUserNeeds]
//    }
    
    
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
        
        saveToPersistentStorage()
        
    }
    
    
    

    func createAllProducts() {
        
        serializeJSON { (products) in
            for product in products {
                _ = product
                saveToPersistentStorage()
                
            }
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




