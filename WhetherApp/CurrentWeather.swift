//
//  CurrentWeather.swift
//  WhetherApp
//
//  Created by abhishek bhatt on 07/12/17.
//  Copyright © 2017 abhishek bhatt. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType:String!
    var _currentTemp: Float!
    
    var cityName: String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
        
    }
    var date: String {
        if _date == nil{
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from:Date ())
        self._date = "Today, \(currentDate)"
        
        return _date
        
    }
    var currentTemp: Float {
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(Current_Whether_Url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemperature = main["temp"] as? Float {
                        
                        let kelvinToCelcius = (currentTemperature - 273.15)
                        
                        self._currentTemp = kelvinToCelcius
                        print(self._currentTemp)
                    }
                }
            }
            completed()
        }
    }
}


