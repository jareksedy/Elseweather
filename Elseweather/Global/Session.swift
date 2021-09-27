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
    
    var userSettings = [
        "Units": Units.metric,
        "AppBackground": AppBackground.minimalist
    ] as [String : Any]
}

enum Units: Int {
    case metric
    case imperial
}

enum AppBackground: Int {
    case minimalist
    case colored
    case blurhashed
}
