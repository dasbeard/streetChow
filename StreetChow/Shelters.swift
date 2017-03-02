//
//  Shelters.swift
//  StreetChow
//
//  Created by Das Beard on 3/1/17.
//  Copyright © 2017 dasBeard. All rights reserved.
//

import UIKit
import GoogleMaps

class Shelters: NSObject {
    
    let name: String
    let location: CLLocationCoordinate2D
    let address: String
    let phone: String
    let website: String
    let desc: String
    let services: String
    let hours: [String]
    
    
    init(name: String, location: CLLocationCoordinate2D, address: String, phone: String, website: String, desc: String, services: String, hours: [String]) {
        self.name = name
        self.location = location
        self.address = address
        self.phone = phone
        self.website = website
        self.desc = desc
        self.services = services
        self.hours = hours
    }
    
}
