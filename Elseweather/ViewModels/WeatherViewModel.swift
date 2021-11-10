//
//  WeatherViewModel.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import Foundation
import SwiftUI

struct WeatherViewModel {
    let location: Location
    
    let conditionCelsius: String
    let conditionFahrenheit: String
    let conditionCelsiusWithUnits: String
    let conditionFahrenheitWithUnits: String
    
    let locality: String
    
    let lat: String
    let lon: String
    
    let precipitationMetric: Double
    let precipitationImperial: Double
    let precipitationUnitsMetric = "MM"
    let precipitationUnitsImperial = "″"
    let precipitationCaption = "PRECIPITATION"
    
    let cloudCover: Int
    let cloudCoverUnits = "%"
    let cloudCoverCaption = "CLOUD COVER"
    
    let humidity: Int
    let humidityUnits = "%"
    let humidityCaption = "HUMIDITY"
    
    let pressureMetric: Int
    let pressureImperial: Double
    let pressureUnitsMetric = "MBAR"
    let pressureUnitsImperial = "″HG"
    let pressureCaption = "PRESSURE"
    
    let uv: Int
    let uvCaption = "UV"
    
    let windMetric: Double
    let windImperial: Double
    let windUnitsMetric = "KPH"
    let windUnitsImperial = "MPH"
    let windCaption = "WIND SPEED"
    let windDegree: Int
    let windDirection: String
    let windDirectionCaption = "DIRECTION"
    let windGustMetric: Double
    let windGustImperial: Double
    let windGustUnitsMetric = "KPH"
    let windGustUnitsImperial = "MPH"
    let windGustCaption = "GUST"
    
    let localDate: String
    let localDateUS: String
    let localTime: String
    let localTimeZone: String
    
    let blurHash: String
}

