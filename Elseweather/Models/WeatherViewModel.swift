//
//  WeatherViewModel.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import Foundation

struct WeatherViewModel {
    let condition: String
    let locality: String
    
    let lat: String
    let lon: String
    
    let precipitation: Double
    let precipitationUnits: String
    
    let cloudCover: Int
    let cloudCoverUnits: String
    
    let humidity: Int
    let humidityUnits: String
    
    let pressure: Double
    let pressureUnits: String
    
    let uv: Int
    
    let wind: Double
    let windUnits: String
    let windDegree: Double
    let windDirection: String
    let windGust: Double
    let windGustUnits: String
    
    let localDate: String
    let localTime: String
    let localTimeZone: String
}

