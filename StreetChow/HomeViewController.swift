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
    
    var destinations = [Shelters(name:"Hippie Kitchen", location:CLLocationCoordinate2D(latitude: 34.040715, longitude: -118.242004), address: "821 E 6th St, Los Angeles, 90021", phone: 15555555555, website: "lacatholicworker.org", desc: "Some Description, Some Description, Some Description, Some Description, Some Description, Some Description, Some Description", services: "Some extra services, there are a lot of other services. Some extra services, there are a lot of other services. Some extra services, there are a lot of other services. Some extra services, there are a lot of other services. Some extra services, there are a lot of other services. Some extra services, there are a lot of other services. ", days:["Monday", "Tuesday", "Wednesday", "Thursday"], startTime: ["1:00pm", "2:00pm", "1:00pm", "4:00pm"], endTime: ["5:00pm", "8:00pm", "4:00pm", "7:30pm"]),
                        
                        Shelters(name:"Seventh-day Adventist Church", location:CLLocationCoordinate2D(latitude: 34.152369, longitude: -118.214568), address: "2322 Merton Ave, Los Angeles, 90041", phone: 3232575803, website: "seektobefamily.org", desc: "Some Description", services: "Some extra services", days:["Monday", "Tuesday"], startTime: ["1:00pm", "2:00pm"], endTime: ["5:00pm", "8:00pm"]),
                        
                        Shelters(name:"First Presbyterian Church", location:CLLocationCoordinate2D(latitude: 34.184897, longitude: -118.305010), address: "521 E Olive Ave, Burbank, 91501", phone: 8188425103, website: "burbankpres.org", desc: "Some Description", services: "Some extra services", days:["Monday", "Tuesday", "Wednesday", "Thursday"], startTime: ["1:00pm", "2:00pm", "1:00pm", "4:00pm"], endTime: ["5:00pm", "8:00pm", "4:00pm", "7:30pm"]),
                        
                        Shelters(name:"Burbank Temporary Aid Center", location:CLLocationCoordinate2D(latitude: 34.182730, longitude: -118.326058), address: "1304 W Burbank Blvd, Burbank, 91506", phone: 8188482822, website: "burbanktemporaryaidcenter.org", desc: "Some Description", services: "Some extra services", days:["Monday", "Tuesday"], startTime: ["1:00pm", "2:00pm"], endTime: ["5:00pm", "8:00pm"])
                        ]
    
    
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
            mapImageOutlet.image = #imageLiteral(resourceName: "StadardIcon")
        } else {
            myMapViewOutlet.mapType = .normal
            mapImageOutlet.image = #imageLiteral(resourceName: "HybridIcon")
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
        
        recenterImageOutlet.image = #imageLiteral(resourceName: "TargetIcon")
        mapImageOutlet.image = #imageLiteral(resourceName: "HybridIcon")

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
            for day in 0 ..< destinations[pin].days.count{
                if day > 0 {
                    snip += ", " + String(destinations[pin].days[day]) + " " + String(destinations[pin].startTime[day]) + "-" + String(destinations[pin].endTime[day])
                } else {
                    snip += String(destinations[pin].days[day]) + " " + String(destinations[pin].startTime[day]) + "-" + String(destinations[pin].endTime[day])
                }
            }
            snip += "\n " + "Phone Number: " + String(destinations[pin].phone)
            
            marker.position = destinations[pin].location
            
            marker.title = destinations[pin].name
            marker.snippet = snip
            marker.map = myMapViewOutlet
        }
        
        
        
//        ///API Request
//        let url = URL(string: "http://192.168.1.133:3000/sessions/mobile.json")
//        // create a URLSession to handle the request tasks
//        let session = URLSession.shared
//        // create a "data task" to make the request and run completion handler
//        let task = session.dataTask(with: url!, completionHandler: {
//            data, response, error in
//            
//            do {
//                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                    if let results = jsonResult["results"] as? NSArray {
//                        for shelter in results {
//                            let shelterDict = shelter as! NSDictionary
//                            self.destinations.append(shelterDict[shelter] as! Shelters)
//                        }
//                    }
//                    DispatchQueue.main.async {
//                    }
//                }
//            } catch {
//                print(error)
//            }
//
//        })
//
//        task.resume()
        
        
        
        
        
        
        
        
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

















