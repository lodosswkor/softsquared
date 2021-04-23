//
//  LocationHelper.swift
//  airpollution
//
//  Created by lodossw on 2021/04/23.
//

import Foundation
import CoreLocation

class LocationHelper:NSObject, CLLocationManagerDelegate {
    
    static var sharedInstance = LocationHelper()
    var locationManager:CLLocationManager!
    var lat : Double;
    var lng : Double;
    
    override init() {
        lat = 0.0;
        lng = 0.0;
    }

    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
           locationManager.startUpdatingLocation()
        }
    }
    
    
    //-- delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lat = location.coordinate.latitude
            lng = location.coordinate.longitude
            
            print("lh \(lat),\(lng)")
        }
    }

    
}
