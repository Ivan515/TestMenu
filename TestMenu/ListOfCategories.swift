//
//  ViewController.swift
//  TestMenu
//
//  Created by Andrey Apet on 10.02.17.
//  Copyright © 2017 i.Apet. All rights reserved.
//

import UIKit
import AEXML

class ListOfCategories: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableOfCategories: UITableView!
    
    var categories = [Category]()
    var offers = [Offer]()
    let iconsForCategories = [#imageLiteral(resourceName: "pizza"), #imageLiteral(resourceName: "sets"), #imageLiteral(resourceName: "spaguetti"), #imageLiteral(resourceName: "sushi"), #imageLiteral(resourceName: "sooup"), #imageLiteral(resourceName: "salad"), #imageLiteral(resourceName: "rice "), #imageLiteral(resourceName: "napitki"), #imageLiteral(resourceName: "desert"), #imageLiteral(resourceName: "roll"), #imageLiteral(resourceName: "zakus"), #imageLiteral(resourceName: "combo"), #imageLiteral(resourceName: "adds"), #imageLiteral(resourceName: "shashl"), #imageLiteral(resourceName: "partymaker")]
    var xmlData: Data {
        get {
            if let returnVal = UserDefaults.standard.object(forKey: "document") {
                return returnVal as! Data
            } else {
                let data = try? Data(contentsOf: URL(string:"http://ufa.farfor.ru/getyml/?key=ukAXxeJYZN")!)
                self.xmlData = data!
                return data!
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "document")
            UserDefaults.standard.synchronize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableOfCategories.delegate = self
        self.tableOfCategories.dataSource = self
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.parseCategories(xmlData)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.categories[indexPath.row].name
        cell.imageView?.image = self.iconsForCategories[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableOfCategories.deselectRow(at: indexPath, animated: true)
    }
    
    func parseCategories(_ data: Data) {
        let document = try! AEXMLDocument(xml: self.xmlData)
        if let parsedCategories = document.root["shop"]["categories"]["category"].all {
            for category in parsedCategories {
                if let name = category.value, let identifier = category.attributes["id"] {
                    let newCategory = Category(name: name, id:identifier)
                    self.categories.append(newCategory)
                }
            }
            self.tableOfCategories.reloadData()
        }
    }
    
    func parseOffers(_ id: String, data: Data) {
        self.offers = []
        let document = try!AEXMLDocument(xml: self.xmlData)
        let parsedOffers = document.root["shop"]["offers"].children
        for offer in parsedOffers {
            if offer["categoryId"].string == id {
                let newDish = Offer(name: offer["name"].string, price: offer["price"].string, descr: offer["description"].string, picture: offer["picture"].string, id: offer["categoryId"].string, weight: offer["param"].all(withAttributes: ["name" : "Вес"])![0].string)
                self.offers.append(newDish)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "offerVC" {
            if let indexPath = self.tableOfCategories.indexPathForSelectedRow {
                if self.tableOfCategories.cellForRow(at: indexPath)?.textLabel?.text == (String: "Патимейкер") {
                    let alert = UIAlertController(title: "Извините...", message: "Данная категория пуста", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                let destinationVC = segue.destination as! DishessVC
                self.parseOffers(self.categories[indexPath.row].id, data: self.xmlData)
                destinationVC.offers = self.offers
                destinationVC.category = self.categories[indexPath.row]
            }
        }
    }
    
}

