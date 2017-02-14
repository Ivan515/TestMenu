//
//  DishessVC.swift
//  TestMenu
//
//  Created by Andrey Apet on 11.02.17.
//  Copyright © 2017 i.Apet. All rights reserved.
//

import UIKit

class DishessVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableOfDishess: UITableView!
    
    var category: Category!
    var offers = [Offer]()
    var imageOfDish = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableOfDishess.delegate = self
        self.tableOfDishess.dataSource = self
        self.title = self.category.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithDish", for: indexPath) as! CustomCell
        
        cell.nameOfDish.text = self.offers[indexPath.row].name
        cell.weightOfDish.text = self.offers[indexPath.row].weight
        cell.priceOfDish.text = self.offers[indexPath.row].price
        cell.imageOfDish.imageFromServerURL(urlString: self.offers[indexPath.row].picture)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableOfDishess.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsOfDish" {
            if let indexPath = self.tableOfDishess.indexPathForSelectedRow {
                let destinationVC = segue.destination as! DishDetailsVC
                destinationVC.dish = self.offers[indexPath.row]
                destinationVC.indexOfImage = self.offers[indexPath.row].picture
            }
        }
    }
    
}
