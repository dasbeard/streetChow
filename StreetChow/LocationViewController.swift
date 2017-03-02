//
//  LocationViewController.swift
//  StreetChow
//
//  Created by Das Beard on 2/27/17.
//  Copyright © 2017 dasBeard. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
// Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    var destinations = [Shelters]()

    
    
    
// Outlets and Actions :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
    
    
    
// UI Lifecycle :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let appDel = UIApplication.shared.delegate as! AppDelegate
        for shelter in appDel.destinations!{
            destinations.append(shelter)
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
