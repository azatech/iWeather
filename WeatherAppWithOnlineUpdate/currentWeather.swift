//
//  currentWeather.swift
//  WeatherAppWithOnlineUpdate
//
//  Created by Azat IOS on 26.07.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    var _cityName:    String!
    var _date:        String!
    var _weatherType: String!
    var _currentTemp: Double!

    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }

    var date: String {
        if _date == nil {
            _date = ""
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentData = dateFormatter.string(from: Date())
        self._date = "Today \(currentData)"
        return _date
        
    }
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }

    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }

    func downloadWeatherDetails(completed: @escaping DownloadComplete)  {
        // Alamofire Download
//        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON {
            response in
                let result = response.result

            if let dict = result.value as? Dictionary <String, AnyObject> {

                if let name = dict["name"] as? String {

                    self._cityName = name.capitalized

                } // name

                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {

                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized

                    } // weather
                }

                if let main = dict["main"] as? Dictionary<String, AnyObject> {

                    // Converting From Kelvin to Celsius
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvinToCelcius = currentTemperature - 273.15
                        let roundedCelsius = Double(round(10*kelvinToCelcius)/10)
                        /// need to add 
                        self._currentTemp = roundedCelsius
                    } // main
                }
            }
            completed()
        }
    }
}
