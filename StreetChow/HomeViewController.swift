//
//  ViewController.swift
//  StreetChow
//
//  Created by Das Beard on 2/27/17.
//  Copyright © 2017 dasBeard. All rights reserved.
//

import UIKit
import GoogleMaps


class HomeViewController: UIViewController, CLLocationManagerDelegate {

// Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    var locationManager: CLLocationManager?
    
    var destinations = [Shelters(name:"Hippie Kitchen", location:CLLocationCoordinate2D(latitude: 34.040715, longitude: -118.242004), address: "821 E 6th St, Los Angeles, 90021", phone: "(213) 614-9615", website: "lacatholicworker.org", desc: "Some Description", services: "Some extra services", hours: ["Monday 1pm-5pm", "Tuesday 2pm-8pm"]),
                        
                        Shelters(name:"Eagle Rock Seventh-day Adventist Church", location:CLLocationCoordinate2D(latitude: 34.152369, longitude: -118.214568), address: "2322 Merton Ave, Los Angeles, 90041", phone: "(323) 257-5803", website: "seektobefamily.org", desc: "Some Description", services: "Some extra services", hours: ["Monday 1pm-5pm", "Tuesday 2pm-8pm"]),
                        
                        Shelters(name:"First Presbyterian Church", location:CLLocationCoordinate2D(latitude: 34.184897, longitude: -118.305010), address: "521 E Olive Ave, Burbank, 91501", phone: "(818) 842-5103", website: "burbankpres.org", desc: "Some Description", services: "Some extra services", hours: ["Monday 1pm-5pm", "Tuesday 2pm-8pm"]),
                        
                        Shelters(name:"Burbank Temporary Aid Center", location:CLLocationCoordinate2D(latitude: 34.182730, longitude: -118.326058), address: "1304 W Burbank Blvd, Burbank, 91506", phone: "(818) 848-2822", website: "burbanktemporaryaidcenter.org", desc: "Some Description", services: "Some extra services", hours: ["Monday 1pm-5pm", "Tuesday 2pm-8pm"])
                        ]
    
    
    
    
    
//    var destinations = [Shelters]()
    
// Outlets and Actins :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    @IBOutlet weak var changeMapLabel: UILabel!
    
    @IBOutlet weak var myMapViewOutlet: GMSMapView!
    
    @IBOutlet weak var mapImageOutlet: UIImageView!
    
    @IBOutlet weak var recenterImageOutlet: UIImageView!
    
    @IBAction func nearByButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "LocalListSegue", sender: sender)
    }

    @IBAction func changeMapViewButton(_ sender: UIButton) {
        if myMapViewOutlet.mapType == .normal{
            myMapViewOutlet.mapType = .hybrid
            mapImageOutlet.image = #imageLiteral(resourceName: "parks-25-128")
        } else {
            myMapViewOutlet.mapType = .normal
            mapImageOutlet.image = #imageLiteral(resourceName: "parks-31-128")
        }
    }
    
    @IBAction func recentButtonPressed(_ sender: UIButton) {
        if let myLocation = self.myMapViewOutlet.myLocation{
            CATransaction.begin()
            CATransaction.setValue(1.2, forKey: kCATransactionAnimationDuration)
            self.myMapViewOutlet?.animate(to: GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 14))
            CATransaction.commit()
        }
    }
    
    
    
    
// UI Lifecycle :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.destinations = destinations
        
        myMapViewOutlet.isMyLocationEnabled = true
        myMapViewOutlet.mapType = .normal
        
        recenterImageOutlet.image = #imageLiteral(resourceName: "07_Target_Keyword-64")
        mapImageOutlet.image = #imageLiteral(resourceName: "parks-31-128")

        let camera = GMSCameraPosition.camera(withLatitude: 34.055458, longitude: -118.259326, zoom: 3.0)
        myMapViewOutlet.animate(to: camera)
        
        
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            if let myLocation = self.myMapViewOutlet.myLocation{
                CATransaction.begin()
                CATransaction.setValue(1.2, forKey: kCATransactionAnimationDuration)
                self.myMapViewOutlet?.animate(to: GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 12.5))
                CATransaction.commit()
            }
        }

        
        for pin in 0 ..< destinations.count{
            let marker = GMSMarker()
            
            var snip: String = ""
            for day in 0 ..< destinations[pin].hours.count{
                snip += String(destinations[pin].hours[day]) + " "
            }
            snip += "\n " + String(destinations[pin].phone)
            
            marker.position = destinations[pin].location
            marker.title = destinations[pin].name
            marker.snippet = snip
            marker.map = myMapViewOutlet
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

// Segue :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        _ = navigationController.topViewController as! LocalListViewController
//        localList.delegate = self

    }
    
    
    
}

















