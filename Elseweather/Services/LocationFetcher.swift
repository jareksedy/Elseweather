//
//  LocationFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 20.10.2021.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: Location?

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func hasAccess() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch manager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                return false
                case .authorizedAlways, .authorizedWhenInUse:
                return true
                @unknown default:
                break
            }
            } else {
                return false
        }
        return false
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stop() {
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lastKnownLocation = (lat: Double(location.coordinate.latitude),
                                 lon: Double(location.coordinate.longitude))
            stop()
        }
    }
}
