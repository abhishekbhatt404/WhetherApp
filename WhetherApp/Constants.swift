//
//  Constants.swift
//  WhetherApp
//
//  Created by abhishek bhatt on 07/12/17.
//  Copyright © 2017 abhishek bhatt. All rights reserved.
//

import Foundation
let Base_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "10996992f042c7122eab5a8196a7ddec"

typealias DownloadComplete = () -> ()

let Current_Whether_Url =  "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=10996992f042c7122eab5a8196a7ddec"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=10996992f042c7122eab5a8196a7ddec"

