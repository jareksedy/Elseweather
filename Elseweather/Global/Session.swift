//
//  Session.swift
//  Elseweather
//
//  Created by Jarek Šedý on 15.09.2021.
//

import Foundation
import SwiftUI

final class Session: ObservableObject {
    
    static let shared = Session()
    
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    let baseUrl = "https://api.weatherapi.com/v1/current.json"
    let dataFileName = "Locations", dataFileExt = "sqlite"
    
    let version = "1.0.0"
    
    // MARK: - Default user settings.
    
    @Published var useMetric = true
    @Published var showUnits = false
    @Published var minimalisticAppearance = false
}
