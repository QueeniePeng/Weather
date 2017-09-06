//
//  WeatherClient.swift
//  Weather
//
//  Created by pengQueenie on 2017/9/6.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit
import Alamofire

class WeatherClient: NSObject {
    let weatherRequest = WeatherRequest()
    
    func WeatherDetail(completion: @escaping (_ results: WeatherResult?, _ error: NSError?) -> Void) {
        Alamofire.request(weatherRequest.weatherURL!).responseJSON { response in
            if let JSON = response.result.value as? [String: AnyObject] {
                print("json: \(JSON)")
                
                guard let weather = JSON[Constants.MapResponseKeys.Weather] as? [String: AnyObject] else { return }
                guard let wind = JSON[Constants.MapResponseKeys.Wind] as? [String: AnyObject] else { return }
                guard let main = JSON[Constants.MapResponseKeys.Main] as? [String: AnyObject] else { return }
                
                if let status = weather[Constants.MapResponseKeys.Status] as? String,
//                   let description = weather[Constants.MapResponseKeys.Description] as? String,
                   let cityName = JSON[Constants.MapResponseKeys.CityName] as? String,
                   let speed = wind[Constants.MapResponseKeys.Speed] as? Double,
                   let temp = main[Constants.MapResponseKeys.Temp] as? Double,
                   let humidity = main[Constants.MapResponseKeys.Humidity] as? Int {
                    
                   let weatherResult = WeatherResult.init(temp: temp, speed: speed, status: status, humidity: humidity, cityName: cityName)
                    
                    OperationQueue.main.addOperation({
                        completion((weatherResult), nil)
                    })
                    
                } else {
                    
                }
                
                
                
            }
        
        }

    }
}
