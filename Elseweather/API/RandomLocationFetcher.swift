//
//  LocationFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import Alamofire

class RandomLocationFetcher {
    
    var locations: [Location] = []
    
    init() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.loadLocations { data in
                self.parseLocations(data: data)
            }
        }
    }
    
    func get() -> Location? {
        return locations.count > 0 ? locations[Int.random(in: 0...locations.count)] : nil
    }
    
    fileprivate func loadLocations(_ completion: @escaping (Data) -> ()) {
        
        guard let url = Bundle.main.url(forResource: "LocationCoordinates", withExtension: "csv") else {
            fatalError("Could not locate LocationCoordinates.csv. Terminating.")
        }
        
        AF.request(url, method: .get).responseData{ response in
            
            guard let data = response.data else { fatalError("Could not load LocationCoordinates.csv. Terminating.") }
            completion(data)
        }
    }
    
    fileprivate func parseLocations(data: Data) {
        
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
