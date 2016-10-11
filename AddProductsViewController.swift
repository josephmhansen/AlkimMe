//
//  AddProductsViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/10/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit
import CoreData

class AddProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, AddProductTableViewCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    func haveProductValueChanged(sender: AddProductsTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender),
            let product = ProductController.sharedController.fetchedResultsController?.object(at: indexPath)  else { return }
        
        product.have = !product.have
        sender.updateHaveButton(have: product.have)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ProductController.sharedController.fetchedResultsController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = ProductController.sharedController.fetchedResultsController?.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = ProductController.sharedController.fetchedResultsController?.sections else { return 0 }
        return sections.count
    }
    
   
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = ProductController.sharedController.fetchedResultsController?.sections,
            let index = Int(sections[section].name) else { return nil }
        
        if index == 0 {
            return "Have"
        } else {
            return "Need"
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? AddProductsTableViewCell,
            let product = ProductController.sharedController.fetchedResultsController?.object(at: indexPath) else { return UITableViewCell() }
        
        cell.updateWithProduct(product: product)
        cell.delegate = self
        return cell
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case.delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case.insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case.move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case.update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }

    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = NSIndexSet(index: sectionIndex)
        
        switch type {
        case.delete:
            tableView.deleteSections(indexSet as IndexSet, with: .bottom)
            
        case.insert:
            tableView.insertSections(indexSet as IndexSet, with: .bottom)
            
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
