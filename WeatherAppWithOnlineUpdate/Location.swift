//
//  Location.swift
//  WeatherAppWithOnlineUpdate
//
//  Created by Azat IOS on 28.07.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}

    var latitude: Double!
    var longitude: Double!
}
