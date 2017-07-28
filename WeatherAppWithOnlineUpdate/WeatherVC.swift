//
//  WeatherVC.swift
//  WeatherAppWithOnlineUpdate
//
//  Created by Azat IOS on 24.07.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    //Declaring Instants
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        tableView.delegate   = self
        tableView.dataSource = self

        currentWeather = CurrentWeather()
//        forecast = Forecast()


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }

    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude  = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                    //Setup UI to load the downloaded data
                }
            }

        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    

    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Downloading forecast weather data for TableView
        
        Alamofire.request(FORECAST_URL).responseJSON {
            response in
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject> {

                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {

                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
                completed()
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as? WeatherCell {

            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }

    func updateMainUI() {
        dateLabel.text                = currentWeather.date
        currentTemperatureLabel.text  = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text  = currentWeather.weatherType
        locationLabel.text            = currentWeather.cityName
        currentWeatherImage.image     = UIImage(named: currentWeather.weatherType)
    }
}

