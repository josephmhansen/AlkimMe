//
//  RoutineStepTableViewCell.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/20/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

class RoutineStepTableViewCell: UITableViewCell {
    
//    weak var delegate: RoutineStepTableViewCellDelegate?

    @IBOutlet weak var instructionsStackView: UIStackView!
    
    @IBOutlet weak var stepProductNameLabel: UILabel!
    @IBOutlet weak var productLogoImageView: UIImageView!

    @IBOutlet weak var stepProductInstructions: UITextView!
    
    @IBAction func nextButtonTapped(_ sender: AnyObject) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension RoutineStepTableViewCell {
    func updateWithProductStep(product: Product) {
        stepProductNameLabel.text = product.name
        productLogoImageView.image = UIImage(named: "\(product.logoName)")
        stepProductInstructions.text = product.instructions
    }
}
