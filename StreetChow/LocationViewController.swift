//
//  LocationViewController.swift
//  StreetChow
//
//  Created by Das Beard on 2/27/17.
//  Copyright © 2017 dasBeard. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationViewController: UIViewController {
    
// Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    var destination: Shelters?
    
    
    
    
// Outlets and Actions :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    @IBOutlet weak var descriptionLabelOutlet: UILabel!
    
    @IBOutlet weak var servicesLabelOutlet: UILabel!
    
    @IBOutlet weak var dayTableView: UITableView!
    
    @IBOutlet weak var locationMapView: GMSMapView!
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
// UI Lifecycle :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
   
        locationMapView.isMyLocationEnabled = true
        
        let camera = GMSCameraPosition.camera(withLatitude: (destination?.location.latitude)!, longitude: (destination?.location.longitude)!, zoom: 16)
        locationMapView.animate(to: camera)
    
        let marker = GMSMarker()
        marker.position = (destination?.location)!
        marker.title = destination?.name
        marker.map = locationMapView
        
        descriptionLabelOutlet.text = destination?.desc
        servicesLabelOutlet.text = destination?.services
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
