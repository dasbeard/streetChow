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
    let phone: UInt64
    let website: String
    let desc: String
    let services: String
    let days: [String]
    let startTime: [String]
    let endTime: [String]
    
    
    init(name: String, location: CLLocationCoordinate2D, address: String, phone: UInt64, website: String, desc: String, services: String, days: [String], startTime: [String], endTime: [String]) {
        self.name = name
        self.location = location
        self.address = address
        self.phone = phone
        self.website = website
        self.desc = desc
        self.services = services
        self.days = days
        self.startTime = startTime
        self.endTime = endTime
    }
    
}
