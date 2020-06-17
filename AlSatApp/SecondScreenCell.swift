//
//  SecondScreenCell.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 17.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit

class SecondScreenCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
