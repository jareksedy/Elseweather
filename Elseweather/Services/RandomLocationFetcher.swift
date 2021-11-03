//
//  RandomLocationFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import SQLite3

final class RandomLocationFetcher {
    private var db: OpaquePointer?
    private let queryStatementString = "SELECT * FROM locations ORDER BY RANDOM() LIMIT 1"
    private var location: Location?
    
    init() {
        DispatchQueue.global(qos: .userInteractive).sync {
            self.db = openDB()
        }
    }
    
    func fetch() -> Location {
        var queryStatement: OpaquePointer?
        let defaultLocation = Location(lat: 43.22, lon: 76.85)
        
        DispatchQueue.global(qos: .userInteractive).sync { 
            if sqlite3_prepare_v2(self.db, self.queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                if sqlite3_step(queryStatement) == SQLITE_ROW {
                    let queryResultLat = sqlite3_column_double(queryStatement, 1)
                    let queryResultLon = sqlite3_column_double(queryStatement, 2)
                    
                    self.location = Location(lat: queryResultLat, lon: queryResultLon)
                }
                sqlite3_finalize(queryStatement)
            }
        }
        
        return self.location ?? defaultLocation
    }
    
    private func openDB() -> OpaquePointer? {
        guard let url = Bundle.main.url(forResource: Session.shared.dataFileName, withExtension: Session.shared.dataFileExt) else {
            fatalError("Could not locate \(Session.shared.dataFileName).\(Session.shared.dataFileExt). Terminating.")
        }
        
        if sqlite3_open(url.absoluteString, &db) == SQLITE_OK {
            return db
        } else {
            fatalError("Could not open database. Terminating.")
        }
    }
}
