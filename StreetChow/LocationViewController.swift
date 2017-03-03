//
//  LocationViewController.swift
//  StreetChow
//
//  Created by Das Beard on 2/27/17.
//  Copyright © 2017 dasBeard. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
// Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    var destination: Shelters?
    var number: UInt64 = 0
    var showNumber = ""
    var numLength = 0
    var count = 0
    var flag = true
    var lat = 0.0
    var long = 0.0
    var addr = ""
    var wSite:String = ""
    
    
// Outlets and Actions :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBAction func openSiteButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://\(wSite)")!, options: [:], completionHandler: nil)
    }
    
    @IBOutlet weak var descriptionOutlet: UITextView!
    
    @IBOutlet weak var servicesOutlet: UITextView!
    
    @IBOutlet weak var dayTableView: UITableView!
    
    @IBOutlet weak var locationMapView: GMSMapView!
    
    @IBOutlet weak var phoneNumberView: UIView!
    
    @IBOutlet weak var newNumberLabel: UILabel!
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func mapButtonPressed(_ sender: UIButton) {
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
           /// Open Google Maps
            UIApplication.shared.open(NSURL(string: "comgooglemaps://?daddr=\(addr)&directionsmode=transit") as! URL, options: [:], completionHandler: nil)
        } else {
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(lat, long)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = destination!.name
            mapItem.openInMaps(launchOptions: options)
        }
    }
 

    

    
    
// UI Lifecycle :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    /// Tap Recognition
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        newNumberLabel.addGestureRecognizer(tap)
        newNumberLabel.isUserInteractionEnabled = true
        phoneNumberView.addGestureRecognizer(tap)
        phoneNumberView.isUserInteractionEnabled = true

        
    /// Rounding Corners
        locationMapView.layer.cornerRadius = 8.0
        newNumberLabel.layer.cornerRadius = 8.0
        phoneNumberView.layer.cornerRadius = 8.0
                

    /// Setting the Map
        locationMapView.isMyLocationEnabled = true
        
        let camera = GMSCameraPosition.camera(withLatitude: (destination?.location.latitude)!, longitude: (destination?.location.longitude)!, zoom: 16)
        locationMapView.animate(to: camera)
    
        let marker = GMSMarker()
        marker.position = (destination?.location)!
        marker.title = destination?.name
        marker.map = locationMapView
        
        if let nlat = destination?.location.latitude{
            lat = nlat
        }
        
        if let nlong = destination?.location.longitude{
            long = nlong
        }
        
        
        
    /// Parsing the phone number
        if let Adder = destination?.address{
            let splitAddr = Adder
            addr = splitAddr.replacingOccurrences(of: " ", with: "+")
        }
        
        if let phoneInt = destination?.phone{
            let numInt = phoneInt
            number = numInt
            let numStr = String(numInt)
            numLength = numStr.characters.count
            
            for i in numStr.characters{
                if numStr.characters.count == 11 && flag == true{
                    flag = false
                }
                else if count == 0{
                    showNumber += "(\(i)"
                    count += 1
                }
                else if count == 2{
                    showNumber += "\(i)) "
                    count += 1
                }
                else if count == 6{
                    showNumber += "-\(i)"
                    count += 1
                }
                else {
                    showNumber += "\(i)"
                    count += 1
                }
            }
        }

        newNumberLabel.text = showNumber
        if let mySite = destination?.website{
            wSite = mySite
        }
        
        
    /// Setting Lables
        servicesOutlet.isEditable = false
        descriptionOutlet.isEditable = false
        servicesOutlet.text = destination?.services
        descriptionOutlet.text = destination?.desc
        title = destination?.name
        websiteLabel.text = destination?.website
        
        
    /// Fix tableview padding
        dayTableView.contentInset = UIEdgeInsets(top: -60, left: 0, bottom:0, right: 0)
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
// Tableview Methods ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (destination?.days.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        
        cell.textLabel?.text = destination?.days[indexPath.row]
        cell.detailTextLabel?.text = (destination?.startTime[indexPath.row])! + "-" + (destination?.endTime[indexPath.row])!
        
        
        return cell
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        servicesOutlet.setContentOffset(CGPoint.zero, animated: false)
    }
    
    

    
// Helper Functions
    func handleTap(_ sender: UITapGestureRecognizer) {
    
        if (UIApplication.shared.canOpenURL(URL(string:"tel://")!)) {
            UIApplication.shared.open(NSURL(string: "tel://\(number)") as! URL, options: [:], completionHandler: nil)
        } else {
            let alertHigh = UIAlertController(title: "No Sim!", message: "Phone is unavailable", preferredStyle: UIAlertControllerStyle.alert)
            alertHigh.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in
                // Run Function Here
            }))
            self.present(alertHigh, animated: true, completion: nil)
        }
        
        
    }

    
    
    
    


    
    
    
    
}













