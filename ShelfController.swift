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
    
    static var productsUserHas: [Product] = [] {
        
    }
    
    
    
    
    
    func createProductArrayForShelf(_ product: Product) -> [Product]{
        
        
        return productsUserHas
    }
    
    func orderProductsByPriority(){
        
    }
    
    
    
    func addProductToShelf(_ product: Product) {
        
        productsUserHas.append(product)
        
        ProductController.sharedController.saveToPersistentStorage()
    }
    
    func removeProductFromShelf(_ product: Product) {

        
        ProductController.sharedController.saveToPersistentStorage()
        
    }
    
}
