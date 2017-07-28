//
//  Constants.swift
//  WeatherAppWithOnlineUpdate
//
//  Created by Azat IOS on 26.07.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import Foundation
import CoreLocation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "1ee908749c0bcb28236628dadba7453b"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_URL        = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=1ee908749c0bcb28236628dadba7453b"

