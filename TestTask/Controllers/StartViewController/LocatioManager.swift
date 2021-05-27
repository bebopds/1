//
//  LocatioManager.swift
//  TestTask
//
//  Created by Владимир Колосов on 23.05.2021.
//

import Foundation
import CoreLocation

class LocationManager: CLLocationManager {
    
    static let shared = LocationManager()
   
    var coordinates: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    func locationShared(){
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    }
    
    func coordinate() -> CLLocationCoordinate2D {
         coordinates ?? CLLocationCoordinate2DMake(0, 0)
    }
}
