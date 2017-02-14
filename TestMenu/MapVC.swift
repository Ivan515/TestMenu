//
//  MapVC.swift
//  TestMenu
//
//  Created by Andrey Apet on 10.02.17.
//  Copyright © 2017 i.Apet. All rights reserved.
//

import UIKit

class MapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    let foodCoordinate = CLLocationCoordinate2D(latitude: 37.789271587670768, longitude: -122.40575965493917)
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.delegate = self
    
        self.locationManager.startUpdatingLocation()
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        
        self.marker.position = foodCoordinate
        self.marker.title = "Ufa Farfor"
        self.marker.map = self.mapView
        
        if self.revealViewController() != nil {
            self.menuButton.target = self.revealViewController()
            self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        let geoCoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(coordinate) { (respone, Error) in
            if let address = respone?.firstResult() {
                let lines = address.lines as [String]!
                self.marker.snippet = (lines?.joined(separator: "\n"))!
                UIView.animate(withDuration: 0.25, animations: { self.view.layoutIfNeeded() })
            }
        }
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            self.reverseGeocodeCoordinate(coordinate: foodCoordinate)
    }

}

