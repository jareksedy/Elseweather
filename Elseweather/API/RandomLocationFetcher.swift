//
//  LocationFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

class RandomLocationFetcher {
    
    var locations: [Location] = []
    
    init() {
        
        guard let url = Bundle.main.url(forResource: "LocationCoordinates", withExtension: "csv") else {
            fatalError("Could not locate app data file.")
        }
        
        guard let data = try? String(contentsOf: url) else {
            fatalError("Could not load app data.")
        }
        
        let locationStringArray = data.components(separatedBy: "\n")
        
        locations = locationStringArray.map {
            let coordinates = $0.components(separatedBy: ",")
            let lat = Double(coordinates[0]) ?? 0.0
            let lon = Double(coordinates[1]) ?? 0.0
            return (lat, lon)
        }
    }
    
    func get() -> Location {
        return locations[Int.random(in: 0...locations.count)]
    }
    
    fileprivate func loadLocations () {
    }
}
