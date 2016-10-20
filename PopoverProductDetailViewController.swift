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
    
    var sectionsSetToOne: Bool {
        if ProductController.sharedController.fetchedResultsController.sections?.count == 2 {
            return false
        } else {
            return true
        }
    }
    
    @IBOutlet weak var productLogoImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productExtendedNameLabel: UILabel!
    @IBOutlet weak var aboutProductTextView: UITextView!
    @IBOutlet weak var applicationInstructionsTextView: UITextView!
    
    
    @IBAction func closeButtonTapped(_ sender: AnyObject) {
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
        aboutProductTextView.text = "\(product.ingredients)"
        applicationInstructionsTextView.text = "\(product.instructions)"
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
