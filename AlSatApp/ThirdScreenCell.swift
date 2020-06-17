//
//  ThirdScreenCell.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 17.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit

class ThirdScreenCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var customerMail: UILabel!
    
    @IBOutlet weak var customerAdress: UILabel!
    
    @IBOutlet weak var bellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
