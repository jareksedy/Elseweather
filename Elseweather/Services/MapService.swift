//
//  MapService.swift
//  Elseweather
//
//  Created by Ярослав on 04.11.2021.
//

import Foundation
import MapKit

class MapService {
    func openInMaps(location: Location, locality: String) {
        let latitude: CLLocationDegrees = location.lat
        let longitude: CLLocationDegrees = location.lon
        let regionDistance: CLLocationDistance = 10_000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates,
                                            latitudinalMeters: regionDistance,
                                            longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = locality
        mapItem.openInMaps(launchOptions: options)
    }
}
