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
    
    let apiKey = "f9979cbf228a4fa2a0e180440212605"
    let baseUrl = "https://api.weatherapi.com/v1/current.json"
    let dataFileName = "LocationCoordinates", dataFileExt = "csv"
    
    // MARK: - User settings.
    
    var units: Units = .metric
    var displayTemperatureUnits: DisplayUnits = .no
    var appearance: Appearance = .standard
}

// MARK: - User settings enums.

enum Units: Int {
    case metric
    case imperial
}

enum DisplayUnits: Int {
    case yes
    case no
}

enum Appearance: Int {
    case minimal
    case standard
}
