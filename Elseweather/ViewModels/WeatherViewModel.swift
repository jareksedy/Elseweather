//
//  WeatherViewModel.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import Foundation
import SwiftUI

struct WeatherViewModel {
    let condition: String
    let locality: String
    
    let lat: String
    let lon: String
    
    let precipitation: Double
    let precipitationUnits: String
    let precipitationCaption = "PRECIPITATION"
    
    let cloudCover: Int
    let cloudCoverUnits: String
    let cloudCoverCaption = "CLOUD COVER"
    
    let humidity: Int
    let humidityUnits: String
    let humidityCaption = "HUMIDITY"
    
    let pressure: Int
    let pressureUnits: String
    let pressureCaption = "PRESSURE"
    
    let uv: Int
    let uvCaption = "UV"
    
    let wind: Double
    let windUnits: String
    let windCaption = "WIND SPEED"
    let windDegree: Double
    let windDirection: String
    let windDirectionCaption = "DIRECTION"
    let windGust: Double
    let windGustUnits: String
    let windGustCaption = "GUST"
    
    let localDate: String
    let localTime: String
    let localTimeZone: String
    
    let blurHash: String
}

