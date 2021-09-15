//
//  Session.swift
//  Elseweather
//
//  Created by Ярослав on 15.09.2021.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    private init() {}
    
    let apiKey = "f9979cbf228a4fa2a0e180440212605"
    let baseUrl = "https://api.weatherapi.com/v1/current.json"
    let dataFileName = "LocationCoordinates", dataFileExt = "csv"
}
