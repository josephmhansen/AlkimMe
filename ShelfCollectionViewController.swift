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

class ShelfCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate, UIPopoverPresentationControllerDelegate {
    var fetchedResultsController: NSFetchedResultsController<Product>!
    
    // MARK: Properties
    
//    let collectionView: UICollectionView
    var blockOperations: [BlockOperation] = []
//    let products = ProductController.sharedController.fetchedResultsController
    static var products: [Product] = []
    
    
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
        
        collectionView?.reloadData()
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
        return self.fetchedResultsController.sections?.count ?? 0
  
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let items = fetchedResultsController.fetchedObjects?.count else {
            return 0
        }
        return items
        
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productShelfCell", for: indexPath) as? ShelfCollectionViewCell else { return UICollectionViewCell() }
        
        let product = self.fetchedResultsController.object(at: indexPath)
        
//        var product: Product?
//        if sectionsSetToOne == true {
//            product = fetchedResultsController.object(at: indexPath)
//        } else {
//            let newIndexPath = IndexPath(row: indexPath.row, section: 1)
//            product = fetchedResultsController.object(at: newIndexPath)
//        }
//        guard let unwrappedProduct = product else { return UICollectionViewCell() }
        
        cell.updateWithProduct(product: product)

    
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
//        let fromRect: CGRect = collectionView.convert(attributes.frame, to: collectionView.superview)
//        
//        
////            //self.tableView.rectForRowAtIndexPath(indexPath)
////        guard let storyboard = storyboard else { return }
////        
////        let popoverVC = storyboard.instantiateViewController(withIdentifier: "popoverEdit")
////        let nav = UINavigationController(rootViewController: popoverVC)
////        nav.modalPresentationStyle = UIModalPresentationStyle.popover
////        let popover = nav.popoverPresentationController
////        popoverVC.modalPresentationStyle = .popover
////        present(popoverVC, animated: true, completion: nil)
////        guard let popoverController = popoverVC.popoverPresentationController else { return }
////        
//////        popoverController.preferredContentSize = CGSizeMake(width: 320, height: 400)
//////        popover?.delegate = self
//////            CGSizeMake(x: 500, y: 600)
////        popoverController.sourceView = self.view
////        popoverController.sourceRect = fromRect
////        popoverController.permittedArrowDirections = .any
//    }
    
    
    
    //=============================================================
    // MARK: FetchedResultsControllerDelegate Methods
    //=============================================================
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
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
    
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
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

    
   //MARK: 
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductPopover" {
            
//            let popoverVC = segue.destination as! PopoverProductDetailViewController
//            let cell = sender as! ShelfCollectionViewCell
//            let indexPath = collectionView?.indexPath(for: cell)
//            let product = ProductController.sharedController.fetchedResultsController.object(at: indexPath!)
//            popoverVC.product = product
            
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                let controller = segue.destination as? PopoverProductDetailViewController
                controller?.product = fetchedResultsController.object(at: indexPath)
            }
//
            
            
//                controller.popoverPresentationController?.delegate = self
//                controller.preferredContentSize = CGSize(width: 320, height: 400)
            
        }
    }
    
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
   /* override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

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
