//
//  RandomLocationFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import Alamofire

class RandomLocationFetcher {
    
    var locations: [Location] = []
    
    init() {
        parse(data: load())
    }
    
    func fetch() -> Location {
        return locations[Int.random(in: 0...locations.count)]
    }
    
    fileprivate func load() -> Data {
        print("loading data...")
        guard let url = Bundle.main.url(forResource: "LocationCoordinates", withExtension: "csv") else {
            fatalError("Could not locate LocationCoordinates.csv. Terminating.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load LocationCoordinates.csv. Terminating.")
        }
        print("loading data...done!")
        return data
    }
    
    fileprivate func parse(data: Data) {
        
        let locationStringArray = String(decoding: data, as: UTF8.self).components(separatedBy: "\n")
        
        locations = locationStringArray.map {
            let coordinates = $0.components(separatedBy: ",")
            let lat = Double(coordinates[0]) ?? 0.0
            let lon = Double(coordinates[1]) ?? 0.0
            return (lat, lon)
        }
        
        guard locations.count > 0 else { fatalError("Could not parse LocationCoordinates.csv. Terminating.") }
    }
}
