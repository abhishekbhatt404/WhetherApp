//
//  Location.swift
//  WhetherApp
//
//  Created by abhishek bhatt on 10/12/17.
//  Copyright © 2017 abhishek bhatt. All rights reserved.
//


import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude: Double!
    var longitude: Double!
    
}
