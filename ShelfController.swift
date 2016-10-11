//
//  ShelfController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/6/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation
import CoreData


class ShelfController{
    
    
    var product: Product?
    
    //make a computed property to check if product.have is true.
    static var productsUserHas: [Product] = []
    
    
    
    
    
    func createProductArrayForShelf(_ product: Product) -> [Product]{
        
        
        return ShelfController.productsUserHas
    }
    
    func orderProductsByPriority(){
        
    }
    
    
    
    func addProductToShelf(_ product: Product) {
        
        ShelfController.productsUserHas.append(product)
        
        ProductController.sharedController.saveToPersistentStorage()
    }
    
    func removeProductFromShelf(_ product: Product) {

        
        ProductController.sharedController.saveToPersistentStorage()
        
    }
    
}
