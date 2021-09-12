//
//  WeatherModel.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

struct WAWeather: Codable {
    let location: WALocation
    let current: WACurrent
}

struct WALocation: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

struct WACurrent: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: WACondition
    let windMPH: Double
    let windKPH, windDegree: Int
    let windDir: String
    let pressureMB: Int
    let pressureIN, precipMM, precipIN: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF: Double
    let visKM, visMiles, uv: Int
    let gustMPH, gustKPH: Double
    let airQuality: [String: Double]

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMPH = "wind_mph"
        case windKPH = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIN = "pressure_in"
        case precipMM = "precip_mm"
        case precipIN = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMPH = "gust_mph"
        case gustKPH = "gust_kph"
        case airQuality = "air_quality"
    }
}

struct WACondition: Codable {
    let text, icon: String
    let code: Int
}
