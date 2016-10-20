//
//  RoutineViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/15/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit
import CoreData

class RoutineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController<Product>!
    
    
    
    var selectedIndexPath: IndexPath? = nil
    var previousCellIndexPath: IndexPath?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let prioritySortDescriptor = NSSortDescriptor(key: "priority", ascending: true)
        fetchRequest.sortDescriptors = [prioritySortDescriptor]
        
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["have", true as NSNumber])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Error with the initial fetch of the fetchedResultsController: \(error)")
        }
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "routineStepCell", for: indexPath) as? RoutineStepTableViewCell else { return UITableViewCell() }
        let ip = indexPath
        if selectedIndexPath == ip {
            cell.instructionsStackView.isHidden = false
            
        } else {
            cell.instructionsStackView.isHidden = true
        }
        
        let productStep = self.fetchedResultsController.object(at: indexPath)
        
        cell.updateWithProductStep(product: productStep)
        cell.stepProductInstructions.sizeToFit()
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousCellIndexPath = previousCellIndexPath {
            guard let cell = tableView.cellForRow(at: previousCellIndexPath) as? RoutineStepTableViewCell else { return }
            cell.instructionsStackView.isHidden = true
            }
            switch selectedIndexPath {
            case nil:
                selectedIndexPath = indexPath
            default:
                if selectedIndexPath! == indexPath {
                    selectedIndexPath = nil
                } else {
                    selectedIndexPath = indexPath
                }
            }
            
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            tableView.deselectRow(at: indexPath, animated: true)
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            
            self.previousCellIndexPath = indexPath
            
       
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let collapsedStepHeight: CGFloat = 70
        let expandedStepHeight: CGFloat = 450
        
        let ip = indexPath
        if selectedIndexPath != nil {
            if ip == selectedIndexPath {
                return expandedStepHeight
            } else {
                return collapsedStepHeight
            }
        } else {
            return collapsedStepHeight
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath
                else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.insertRows(at: [newIndexPath], with: .fade)
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
    
    


}
