//
//  CustomCell.swift
//  TestMenu
//
//  Created by Andrey Apet on 11.02.17.
//  Copyright © 2017 i.Apet. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var imageOfDish: UIImageView!
    @IBOutlet weak var nameOfDish: UILabel!
    @IBOutlet weak var weightOfDish: UILabel!
    @IBOutlet weak var priceOfDish: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
