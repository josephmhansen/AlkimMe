//
//  ShelfViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/7/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

class ShelfViewController: UIViewController, ShelfCollectionViewDelegate {

    //NSUSer defaults check if app is running for the first time, default to true, if true then create all products. after then set to false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductController.sharedController.serializeJSON { (_) in
            
        }

//        print(ProductController.sharedController.products)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func updateShelfCollectionView(sender: AddProductsTableViewCell) {
        //        reload view with items user has
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
