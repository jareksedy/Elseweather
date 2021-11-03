//
//  RandomLocationFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import SQLite

final class RandomLocationFetcher {
    private let db: Connection?
    private let locations: Table?
    
    init() {
        guard let url = Bundle.main.url(forResource: Session.shared.dataFileName, withExtension: Session.shared.dataFileExt) else {
            fatalError("Could not locate \(Session.shared.dataFileName).\(Session.shared.dataFileExt). Terminating.")
        }
        
        self.db = try! Connection(url.absoluteString)
        self.locations = Table("locations")
    }
    
    func fetch() -> Location {
        let defaultLocation = Location(lat: 43.22, lon: 76.85)
        let query = locations!.order(Expression<Int>.random()).limit(1)

        do {
            for row in try db!.prepare(query) {
                let lat = row[Expression<Double?>("lat")] ?? defaultLocation.lat
                let lon = row[Expression<Double?>("lon")] ?? defaultLocation.lon
                return Location(lat, lon)
            }
        } catch {
            print(error)
        }
        return defaultLocation
    }
}
