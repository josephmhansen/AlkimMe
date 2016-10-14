//
//  ShelfCollectionViewCell.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/10/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

class ShelfCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    //weak var delegate: ShelfCollectionViewCellDelegate?
    
    
    
    
    
    
    
}

extension ShelfCollectionViewCell {
    func updateWithProduct(product: Product) {
        logoImageView.image = UIImage(named: "\(product.logoName)")
        productNameLabel.text = product.name
        productImageView.image = UIImage(named: "\(product.imageName)")
    }
}
