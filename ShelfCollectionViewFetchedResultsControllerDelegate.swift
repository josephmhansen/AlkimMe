//
//  ShelfCollectionViewFetchedResultsControllerDelegate.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/16/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//
/*
import Foundation
import CoreData

class CollectionViewFetchedResultsControllerDelegate: NSObject, NSFetchedResultsControllerDelegate {
    
    // MARK: Properties
    
    private let collectionView: UICollectionView
    private var blockOperations: [BlockOperation] = []
    
    // MARK: Init
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    // MARK: Deinit
    
    deinit {
        blockOperations.forEach { $0.cancel() }
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    func controller(controller: NSFetchedResultsController<AnyObject>, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
            
        case .Insert:
            guard let newIndexPath = newIndexPath else { return }
            let op = NSBlockOperation { [weak self] in self?.collectionView.insertItemsAtIndexPaths([newIndexPath]) }
            blockOperations.append(op)
            
        case .Update:
            guard let newIndexPath = newIndexPath else { return }
            let op = NSBlockOperation { [weak self] in self?.collectionView.reloadItemsAtIndexPaths([newIndexPath]) }
            blockOperations.append(op)
            
        case .Move:
            guard let indexPath = indexPath else { return }
            guard let newIndexPath = newIndexPath else { return }
            let op = NSBlockOperation { [weak self] in self?.collectionView.moveItemAtIndexPath(indexPath, toIndexPath: newIndexPath) }
            blockOperations.append(op)
            
        case .Delete:
            guard let indexPath = indexPath else { return }
            let op = NSBlockOperation { [weak self] in self?.collectionView.deleteItemsAtIndexPaths([indexPath]) }
            blockOperations.append(op)
            
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
            
        case .Insert:
            let op = NSBlockOperation { [weak self] in self?.collectionView.insertSections(NSIndexSet(index: sectionIndex)) }
            blockOperations.append(op)
            
        case .Update:
            let op = NSBlockOperation { [weak self] in self?.collectionView.reloadSections(NSIndexSet(index: sectionIndex)) }
            blockOperations.append(op)
            
        case .Delete:
            let op = NSBlockOperation { [weak self] in self?.collectionView.deleteSections(NSIndexSet(index: sectionIndex)) }
            blockOperations.append(op)
            
        default: break
            
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView.performBatchUpdates({
            self.blockOperations.forEach { $0.start() }
            }, completion: { finished in
                self.blockOperations.removeAll(keepCapacity: false)
        })
    }
    
}
 */
