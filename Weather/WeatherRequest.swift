//
//  WeatherRequest.swift
//  Weather
//
//  Created by pengQueenie on 2017/9/6.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

struct WeatherRequest {
    
    
    // Weather example
    // https://api.openweathermap.org/data/2.5/weather?apikey=a05aaae4b68e837f3062dcd6d31d5655&lat=37&lon=-122

    
    var weatherURL: Foundation.URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.query = "apikey=\(Constants.ApiKey)&\(Constants.MapBodyKeys.Lattitude)=\(Constants.MapBodyValues.Latitude)&\(Constants.MapBodyKeys.Longitude)=\(Constants.MapBodyValues.Longitude)"
        
        print(urlComponents.url!)
        return urlComponents.url
    }
}
