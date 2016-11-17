//
//  ContentViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 11/17/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productLogoImageView: UIImageView!
    @IBOutlet weak var productDirections: UITextView!
    @IBOutlet weak var nextStepProductName: UILabel!
    
    var pageIndex: Int!
    var nameIndex: String!
    var productLogoFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productNameLabel.text = self.nameIndex
        self.productLogoImageView.image = UIImage(named: "\(self.productLogoFile)")
        
        
        
        
        // Do any additional setup after loading the view.
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
