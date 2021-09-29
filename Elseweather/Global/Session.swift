//
//  Session.swift
//  Elseweather
//
//  Created by Jarek Šedý on 15.09.2021.
//

import Foundation

final class Session {
    
    static let shared = Session()
    
    private init() {}
    
    let apiKey = "f9979cbf228a4fa2a0e180440212605"
    let baseUrl = "https://api.weatherapi.com/v1/current.json"
    let dataFileName = "LocationCoordinates", dataFileExt = "csv"
    
    // MARK: - User settings.
    let units: Units = .imperial
    let appBackground: AppBackground = .minimalist
}

// MARK: - User settings enums.

enum Units: Int {
    case metric
    case imperial
}

enum AppBackground: Int {
    case minimalist
    case colored
    case blurhashed
}
