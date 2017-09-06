//
//  WeatherViewController.swift
//  Weather
//
//  Created by pengQueenie on 2017/9/6.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var LBCity: UILabel!
    @IBOutlet weak var LBTemp: UILabel!
    @IBOutlet weak var LBStatus: UILabel!
    @IBOutlet weak var LBSpeed: UILabel!
    @IBOutlet weak var LBHumidity: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let weatherClient = WeatherClient()
        weatherClient.WeatherDetail { (result, error) in
            if let error = error {
                print("error: \(error)")
            }
            guard let result = result else { return }
            self.LBCity.text = (result.cityName).uppercased()
            self.LBStatus.text = result.status
            self.LBTemp.text = String(format: "%.0f", self.convertKelvinToFahrenheit(k: result.temp)) + "F"
            self.LBSpeed.text = "Speed: " + String(describing: result.speed)
            self.LBHumidity.text = "Humidity: " + String(describing: result.humidity) + "%"
            
            self.reloadInputViews()
        }
    }
}

extension WeatherViewController {
    func convertKelvinToFahrenheit(k: Double) -> Double {
        let fahrentheit = 9/5 * (k - 273) + 32

        return fahrentheit
    }
}
