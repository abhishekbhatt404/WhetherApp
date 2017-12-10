//
//  ViewController.swift
//  WhetherApp
//
//  Created by abhishek bhatt on 07/12/17.
//  Copyright © 2017 abhishek bhatt. All rights reserved.

import  UIKit
import  CoreLocation
import  Alamofire

class MainVc: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var currentTemp: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var topWhetherInfo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var CurrentLoc: CLLocation!
    
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        currentWeather = CurrentWeather()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       locationAuthStatus()
    }
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            CurrentLoc = locationManager.location
            Location.sharedInstance.latitude = CurrentLoc.coordinate.latitude
            Location.sharedInstance.longitude = CurrentLoc.coordinate.longitude

            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
            
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()

        }
    }
    func downloadForecastData(completed: @escaping DownloadComplete){
       
        // downloading forecast weather data for Tableview
       
        let forecastURL = URL(string: FORECAST_URL)
        Alamofire.request(forecastURL!).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                        
                    }
                }
                
            }
            completed()
            
        }
        
    }
    
    func updateMainUI(){
        
        date.text = currentWeather.date
        currentTemp.text = "\(currentWeather.currentTemp)"
        topWhetherInfo.text = currentWeather.weatherType
        currentLocation.text = currentWeather.cityName
        topImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    
    
}
extension MainVc: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier : "whetherCell",for : indexPath ) as? TableViewCell {
            
            
            return cell
        }
        else{
            return TableViewCell()
        }
    }
    
}

