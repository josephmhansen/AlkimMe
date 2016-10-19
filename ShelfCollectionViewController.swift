//
//  ShelfCollectionViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/15/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class ShelfCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {

    
    // MARK: Properties
    
//    let collectionView: UICollectionView
    var blockOperations: [BlockOperation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductController.sharedController.fetchedResultsController.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        guard collectionView != nil else { return }
//        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    /*
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let popoverVC = storyboard?.instantiateViewController(withIdentifier: "popoverView") as UIViewController else { return }
        popoverVC.modalPresentationStyle = .none
        present(popoverVC, animated: true, completion: nil)
        let popoverController = popoverVC.popoverPresentationController
        popoverController.sourceView = self.view
        popoverController.sourceRect = fromRect
        popoverController.permitedArrowDirections = .Any
    }
 */

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    var sectionsSetToOne: Bool {
        if ProductController.sharedController.fetchedResultsController.sections?.count == 2 {
            return false
        } else {
            return true
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = ProductController.sharedController.fetchedResultsController.sections?[0].objects as? [Product] else {
            return 0
        }
        guard let firstProduct = items.first else
        { return 0 }
        
        if sectionsSetToOne == true {
            if firstProduct.have == true {
                return items.count
            } else {
                return 0
            }
        } else if sectionsSetToOne == false {
            guard let otherItems = ProductController.sharedController.fetchedResultsController.sections?[1] else { return 0 }
            return otherItems.numberOfObjects
        } else {
            return 0
        }
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productShelfCell", for: indexPath) as? ShelfCollectionViewCell else { return UICollectionViewCell() }
        
        var product: Product?
        if sectionsSetToOne == true {
            product = ProductController.sharedController.fetchedResultsController.object(at: indexPath)
        } else {
            let newIndexPath = IndexPath(row: indexPath.row, section: 1)
            product = ProductController.sharedController.fetchedResultsController.object(at: newIndexPath)
        }
        guard let unwrappedProduct = product else { return UICollectionViewCell() }
        
        cell.updateWithProduct(product: unwrappedProduct)
//        cell.delegate = self
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let fromRect: CGRect = collectionView.convert(attributes.frame, to: collectionView.superview)
        
            //self.tableView.rectForRowAtIndexPath(indexPath)
        guard let storyboard = storyboard else { return }
        
        let popoverVC = storyboard.instantiateViewController(withIdentifier: "popoverEdit") 
        popoverVC.modalPresentationStyle = .popover
        present(popoverVC, animated: true, completion: nil)
        guard let popoverController = popoverVC.popoverPresentationController else { return }
        popoverController.sourceView = self.view
        popoverController.sourceRect = fromRect
        popoverController.permittedArrowDirections = .any
    }
    
    
    //=============================================================
    // MARK: FetchedResultsControllerDelegate Methods
    //=============================================================
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    private func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: AnyObject, atIndexPath indexPath: IndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Object: \(newIndexPath)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView?.insertItems(at: [newIndexPath! as IndexPath])
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.update {
            print("Update Object: \(indexPath)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView?.reloadItems(at: [indexPath! as IndexPath])
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.move {
            print("Move Object: \(indexPath)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView?.moveItem(at: indexPath! as IndexPath, to: newIndexPath! as IndexPath)
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.delete {
            print("Delete Object: \(indexPath)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView?.deleteItems(at: [indexPath! as IndexPath])
                    }
                    })
            )
        }
    }
    
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Section: \(sectionIndex)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView?.insertSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.update {
            print("Update Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView?.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.delete {
            print("Delete Section: \(sectionIndex)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView?.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                    })
            )
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({ () -> Void in
            for operation: BlockOperation in self.blockOperations {
                operation.start()
            }
            }, completion: { (finished) -> Void in
                self.blockOperations.removeAll(keepingCapacity: false)
        })
    }
    
    deinit {
        // Cancel all block operations when VC deallocates
        for operation: BlockOperation in blockOperations {
            operation.cancel()
        }
        
        blockOperations.removeAll(keepingCapacity: false)
    }

    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
