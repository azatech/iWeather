//
//  WeatherCell.swift
//  WeatherAppWithOnlineUpdate
//
//  Created by Azat IOS on 28.07.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!

    // This is the background of Cell-Image
    @IBOutlet weak var cellBgImage: UIImageView!

    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)

        cellBgImage.image = UIImage(named: "\(forecast.weatherType)-img")
        dayLabel.text = forecast.date
    }
} 
