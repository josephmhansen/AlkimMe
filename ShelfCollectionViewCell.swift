//
//  ShelfCollectionViewCell.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/10/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

@IBDesignable

class ShelfCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    weak var delegate: ShelfCollectionViewCellDelegate?
    
    
    
    
    
    
    
}

extension ShelfCollectionViewCell {
    func updateWithProduct(product: Product) {
        let productLogoImage = UIImage(named: "\(product.logoName)")
        logoImageView.image = productLogoImage
        let productImage = UIImage(named: "\(product.imageName)")
        productNameLabel.text = product.name
        
        productImageView.image = productImage
    }
}

protocol ShelfCollectionViewCellDelegate: class {
    func updateShelfCollectionView(sender: AddProductsViewController)
}
