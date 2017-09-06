//
//  LocationPin.swift
//  Weather
//
//  Created by pengQueenie on 2017/9/6.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit
import MapKit

class LocationPin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
}
