//
//  RandomLocationFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

class RandomLocationFetcher {
    
    fileprivate var locations: [Location] = []
    
    init() {
        load()
    }
    
    func fetch() -> Location {
        return locations[Int.random(in: 0...locations.count)]
    }
    
    fileprivate func load() {
        guard let url = Bundle.main.url(forResource: Session.shared.dataFileName, withExtension: Session.shared.dataFileExt) else {
            fatalError("Could not locate \(Session.shared.dataFileName).\(Session.shared.dataFileExt). Terminating.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(Session.shared.dataFileName).\(Session.shared.dataFileExt). Terminating.")
        }
        
        parse(data)
    }
    
    fileprivate func parse(_ data: Data) {
        locations = String(decoding: data, as: UTF8.self).components(separatedBy: "\n").map {
            
            let coordinates = $0.components(separatedBy: ",")
            let lat = Double(coordinates[0]) ?? 0.0
            let lon = Double(coordinates[1]) ?? 0.0
            return (lat, lon)
        }
        
        guard locations.count > 0 else { fatalError("Could not parse \(Session.shared.dataFileName).\(Session.shared.dataFileExt). Terminating.") }
    }
}
