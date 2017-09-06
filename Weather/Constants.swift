//
//  Constants.swift
//  Weather
//
//  Created by pengQueenie on 2017/9/6.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

struct Constants {
    static let ApiKey: String = "a05aaae4b68e837f3062dcd6d31d5655"
    
    struct MapBodyKeys {
        static let Lattitude = "lat"
        static let Longitude = "lon"
    }
    
    struct MapBodyValues {
        static var Latitude = 41.87
        static var Longitude = -87.62
    }
    
    struct MapResponseKeys {
        static let Weather = "weather"
        static let Status = "main"
        static let Description = "description"
        
        static let CityName = "name"
        
        static let Wind = "wind"
        static let Speed = "speed"
        
        static let Main = "main"
        static let Temp = "temp"
        static let Humidity = "humidity"
    }
}
