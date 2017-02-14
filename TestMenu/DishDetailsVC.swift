//
//  DishDetailsVC.swift
//  TestMenu
//
//  Created by Andrey Apet on 13.02.17.
//  Copyright © 2017 i.Apet. All rights reserved.
//

import UIKit

class DishDetailsVC: UIViewController {

    @IBOutlet weak var imageDish: UIImageView!
    @IBOutlet weak var nameDish: UILabel!
    @IBOutlet weak var weightDish: UILabel!
    @IBOutlet weak var priceDish: UILabel!
    @IBOutlet weak var descriptionDish: UILabel!
    
    var dish: Offer!
    var imageOfDish: UIImage!
    
    var indexOfImage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageDish.imageFromServerURL(urlString: self.indexOfImage)
        self.nameDish.text = self.dish.name
        self.weightDish.text = self.dish.weight
        self.priceDish.text = "\(self.dish.price) руб"
        self.descriptionDish.text = self.dish.descr
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
