//
//  AddProductsTableViewCell.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/10/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

@IBDesignable

class AddProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var productLogoSymbol: UIImageView!

    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var haveProduct: UIButton!
    
    weak var delegate: AddProductTableViewCellDelegate?
    
    var product: Product?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    
    
    @IBAction func haveProductBoxChecked(_ sender: AnyObject) {
        if let delegate = delegate {
            delegate.haveProductValueChanged(sender: self)
        }
        
    }
    
    func updateHaveButton(have: Bool) {
        guard let product = product else { return }
        
        if product.have == true {
            haveProduct.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            haveProduct.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
  

}

extension AddProductsTableViewCell {
    func updateWithProduct(product: Product) {
        productNameLabel.text = product.name
        productLogoSymbol.image = UIImage(named: "\(product.imageName)")
        updateHaveButton(have: product.have)
    }
}

protocol AddProductTableViewCellDelegate: class {
    func haveProductValueChanged(sender: AddProductsTableViewCell)
    
}

protocol ShelfCollectionViewDelegate: class {
    func updateShelfCollectionView(sender: AddProductsTableViewCell)
}



