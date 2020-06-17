//
//  MyProductCell.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 16.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit

class MyProductCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var myProductImage: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func delBtn(_ sender: Any) {
        
    }
}
