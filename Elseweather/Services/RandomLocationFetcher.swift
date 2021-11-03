//
//  RandomLocationFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import SQLite

final class RandomLocationFetcher {
    private var locations: [Location] = []
    private var db: Connection?
    
    init() {
        guard let url = Bundle.main.url(forResource: Session.shared.dbFileName, withExtension: Session.shared.dbFileExt) else {
            fatalError("Could not locate \(Session.shared.dbFileName).\(Session.shared.dbFileExt). Terminating.")
        }
        
        do { db = try Connection(url.absoluteString, readonly: true) }
        catch { fatalError(error.localizedDescription) }
    }
    
    func fetch() -> Location {
        let lat = Expression<Double?>("lat")
        let lon = Expression<Double?>("lon")
        
        let table = Table("locations")
        let query = table.order(Expression<Int>.random()).limit(1)
        
        var location: Location?
        
        for row in try! db!.prepare(query) {
            location = Location(lat: row[lat]!, lon: row[lon]!)
        }
        
        return location!
    }
    
    private func load() {
        guard let url = Bundle.main.url(forResource: Session.shared.dataFileName, withExtension: Session.shared.dataFileExt) else {
            fatalError("Could not locate \(Session.shared.dataFileName).\(Session.shared.dataFileExt). Terminating.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(Session.shared.dataFileName).\(Session.shared.dataFileExt). Terminating.")
        }
        
        parse(data)
    }
    
    private func parse(_ data: Data) {
        locations = String(decoding: data, as: UTF8.self).components(separatedBy: "\n").map {
            
            let coordinates = $0.components(separatedBy: ",")
            let lat = Double(coordinates[0]) ?? 0.0
            let lon = Double(coordinates[1]) ?? 0.0
            return (lat, lon)
        }
        
        guard locations.count > 0 else { fatalError("Could not parse \(Session.shared.dataFileName).\(Session.shared.dataFileExt). Terminating.") }
    }
}
