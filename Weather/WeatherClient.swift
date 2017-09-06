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
                
                guard let weatherDic = JSON[Constants.MapResponseKeys.Weather] as? [[String: AnyObject]] else { return }
                guard let wind = JSON[Constants.MapResponseKeys.Wind] as? [String: AnyObject] else { return }
                guard let main = JSON[Constants.MapResponseKeys.Main] as? [String: AnyObject] else { return }
                guard let cityName = JSON[Constants.MapResponseKeys.CityName] as? String else { return }
                
                var status: String = ""
                for weather in weatherDic {
                    if let statusString = weather[Constants.MapResponseKeys.Status] as? String {
                        status = statusString
                    }
                }
                guard let speed = wind[Constants.MapResponseKeys.Speed] as? Double else { return }

                guard let temp = main[Constants.MapResponseKeys.Temp] as? Double else { return }
                guard let humidity = main[Constants.MapResponseKeys.Humidity] as? Int else { return }
//                var speed: Double = 0.0
//                for wind in windDic {
//                    speed = speedDouble
//                }
                
//                var temp: Double = 0.0
//                var humidity: Int = 0
//                for main in mainDic {
//                    
//                    temp = tempDouble
//                    humidity = humidityInt
//
//                }
                
               let weatherResult = WeatherResult.init(temp: temp, speed: speed, status: status, humidity: humidity, cityName: cityName)
                
                OperationQueue.main.addOperation({
                    completion((weatherResult), nil)
                })
            }
        
        }

    }
}
