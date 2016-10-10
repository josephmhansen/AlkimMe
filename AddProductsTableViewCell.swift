//
//  AddProductsTableViewCell.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/10/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

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
    
    func updateWithProduct(product: Product) {
        self.product = product
        productNameLabel.text = product.name
        
        if product.have == true {
            haveProduct.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            haveProduct.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
    
    
    @IBAction func haveProductBoxChecked(_ sender: AnyObject) {
        guard let product = product else { return }
        delegate?.haveProductValueChanged(cell: self, haveProduct: product.have)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}

protocol AddProductTableViewCellDelegate: class {
    func haveProductValueChanged(cell: AddProductsTableViewCell, haveProduct: Bool)
}
