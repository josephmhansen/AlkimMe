//
//  AddProductsViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/10/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit
import CoreData

class AddProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddProductTableViewCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    func haveProductValueChanged(sender: AddProductsTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
            let product = ProductController.sharedController.sortedProducts[indexPath.row]
        
//        product.have = !product.have
//        sender.updateHaveButton(have: product.have)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(ProductController.sharedController.products.count)
//        ProductController.sharedController.fetchedResultsController?.delegate = self
//        print(ProductController.sharedController.fetchedResultsController?.fetchedObjects?.count)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProductController.sharedController.sortedProducts.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductController.sharedController.sortedProducts[section].count
        
    }
    

    
   
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String = ""
        
        switch section {
        case 0:
            title = "Have"
        case 1:
            title = "Need"
        
        default:
            break
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? AddProductsTableViewCell else { return UITableViewCell() }
            let product = ProductController.sharedController.sortedProducts[indexPath.section][indexPath.row]
//            let product = ProductController.sharedController.fetchedResultsController?.object(at: indexPath) else { return UITableViewCell() }
        
        cell.updateWithProduct(product: product)
        cell.delegate = self
        return cell
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
