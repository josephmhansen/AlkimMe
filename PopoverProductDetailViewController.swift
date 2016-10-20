//
//  PopoverProductDetailViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/17/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit
import CoreData

class PopoverProductDetailViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var product: Product?
    var blockOperations: [BlockOperation] = []
    
    
    @IBOutlet weak var productLogoImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productExtendedNameLabel: UILabel!
    @IBOutlet weak var aboutProductTextView: UITextView!
    @IBOutlet weak var applicationInstructionsTextView: UITextView!
    
    
    @IBAction func closeButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func outsideGestureTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

            if let product = product {
            updateWithProduct(product: product)
        }
    }
    
    func updateWithProduct(product: Product) {
        productLogoImageView.image = UIImage(named: product.logoName)
        productNameLabel.text = "\(product.name)"
        priceLabel.text = "$\(product.price)"
    // CHANGE THIS!!!!!!!!!!!
        productExtendedNameLabel.text = "\(product.name)"
        //^^^^^^^^^^^
        aboutProductTextView.text = "\(product.ingredients)"
        applicationInstructionsTextView.text = "\(product.instructions)"
        
    }
}
