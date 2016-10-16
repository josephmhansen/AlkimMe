//
//  AddProductsViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/10/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit
import CoreData

class AddProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddProductTableViewCellDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    func haveProductValueChanged(sender: AddProductsTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let product = ProductController.sharedController.fetchedResultsController.object(at: indexPath)
        ProductController.sharedController.isHaveValueChecked(product: product)
        
        
        
        
//        product.have = !product.have
//        sender.updateHaveButton(have: product.have)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        ProductController.sharedController.fetchedResultsController.delegate = self
//        print(ProductController.sharedController.fetchedResultsController?.fetchedObjects?.count)
//        tableView.reloadData()
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = ProductController.sharedController.fetchedResultsController.sections else {
            fatalError()
            
        }
       return sections.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = ProductController.sharedController.fetchedResultsController.sections else {
            fatalError()
            
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
        
    }
    

    
   
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = ProductController.sharedController.fetchedResultsController.sections,
            let index = Int(sections[section].name) else { return nil }
        
        if index == 1 {
            return "Have"
        } else {
            return "Need"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? AddProductsTableViewCell else { return UITableViewCell() }
//          let product = ProductController.sharedController.sortedProducts[indexPath.section][indexPath.row]
            let product = ProductController.sharedController.fetchedResultsController.object(at: indexPath)
//        cell.product = product
        
        cell.updateWithProduct(product: product)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 25)!
        header.textLabel?.textColor = UIColor.black
    }
    
    
    
    //=============================================================
    // MARK: FetchedResultsControllerDelegate Methods
    //=============================================================
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath
                else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath
                else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
            
        case .delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
        case .insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
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
