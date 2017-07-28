//
//  Constants.swift
//  WeatherAppWithOnlineUpdate
//
//  Created by Azat IOS on 26.07.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "1ee908749c0bcb28236628dadba7453b"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)33\(LONGITUDE)100\(APP_ID)\(API_KEY)"
let FORECAST_URL        = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=1ee908749c0bcb28236628dadba7453b"

