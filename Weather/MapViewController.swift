//
//  ViewController.swift
//  Weather
//
//  Created by pengQueenie on 2017/9/6.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{

    @IBOutlet weak var MapView: MKMapView!
    
    // location
    fileprivate let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    // segue
    fileprivate let segueIdentifier = "ShowWeatherResult"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // location
        checkLocationServicesStatus()
        checkLocationAccessStatus()
        
        MapView.delegate = self
        
        let locationPin = LocationPin(coordinate: CLLocationCoordinate2D(latitude: Constants.MapBodyValues.Latitude, longitude: Constants.MapBodyValues.Longitude))
        
        // TODO: Double Tap annotation to segue, annotation location
        MapView.addAnnotation(locationPin)
    }
    
    // TODO
    func addGestureRecognizer(_ view: UIView) {
        // tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapPerformSegue))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    func doubleTapPerformSegue(tap: UITapGestureRecognizer) {
        MapView.isUserInteractionEnabled = false
        
    }
    
    @IBAction func GetWeather(_ sender: Any) {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
}



// MARK: CLLocation

extension MapViewController: CLLocationManagerDelegate {
    
    // check location service
    func checkLocationServicesStatus() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 500 // meters
            locationManager.startMonitoringSignificantLocationChanges()
            
        } else {
            let alertController = Alert.showAlert("Location", message: "Location service not enable.")
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // check location authorization
    func checkLocationAccessStatus() {
        let status = CLLocationManager.authorizationStatus()
        if status == .denied {
            let deniedAlert = Alert.showAlert("Location", message: "Weather requires location access to use the service.")
            self.present(deniedAlert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        if status == .denied {
            let deniedAlert = Alert.showAlert("Location", message: "Weather requires location access to use the service.")
            self.present(deniedAlert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        // center map
        let lat = Double(round(100 * locationValue.latitude)/100)
        let lon = Double(round(100 * locationValue.longitude)/100)
        print("Location: \nLat: \(lat)\nLon: \(lon)")

        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        centerMapOnLocation(location: initialLocation)
        
        // store current location data
        DispatchQueue.main.async {
            Constants.MapBodyValues.Latitude = lat
            Constants.MapBodyValues.Longitude = lon
        }
    }
}


extension MapViewController {

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        MapView.setRegion(coordinateRegion, animated: true)
    }

}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? LocationPin {
            let identifier = "pin"
            var annotationView: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                annotationView = dequeuedView
                return annotationView
            }
        }
        
        return nil
    }
}
