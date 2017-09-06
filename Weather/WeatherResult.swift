//
//  WeatherDetail.swift
//  Weather
//
//  Created by pengQueenie on 2017/9/6.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

class WeatherResult {
    
    let temp: Double
    let speed: Double
    let status: String
    let humidity: Int
    let cityName: String
    
    init(temp: Double, speed: Double, status: String, humidity: Int, cityName: String) {
        self.temp = temp
        self.speed = speed
        self.status = status
        self.humidity = humidity
        self.cityName = cityName
    }

}
