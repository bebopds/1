//
//  LocationManager + Delegate.swift
//  TestTask
//
//  Created by Владимир Колосов on 23.05.2021.
//

import Foundation
import CoreLocation

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0);

            if manager.location?.coordinate != nil {
                locValue = (manager.location?.coordinate)!
            }
        coordinates = locValue

        manager.stopUpdatingLocation()
    }
}
