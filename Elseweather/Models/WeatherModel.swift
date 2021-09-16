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
    let windMPH, windKPH, windDegree: Double
    let windDir: String
    let pressureMB: Int
    let pressureIN, precipMM, precipIN: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF: Double
    let visKM, visMiles: Double
    let uv: Int
    let gustMPH, gustKPH: Double

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
    }
}

struct WACondition: Codable {
    let text, icon: String
    let code: Int
}

extension WAWeather {
    
    var condition: String {
        
        let customWeatherConditions = [
            1030: "and misty",
            1063: "with rain patches",
            1066: "with snow patches",
            1069: "and sleet",
            1087: "with thundery outbreaks",
            1117: "and blizzard condition",
            1135: "and foggy",
            1147: "with freezing fog",
            1150: "with a light drizzle",
            1153: "with a light drizzle",
            1168: "with freezing drizzle",
            1171: "with freezing drizzle",
            1180: "with rain patches",
            1183: "and a light rain",
            1186: "with rain at times",
            1189: "and raining",
            1192: "with heavy rain at times",
            1195: "and raining heavily",
            1198: "with freezing rain",
            1201: "with heavy freezing rain",
            1204: "with sleet",
            1207: "with heavy sleet",
            1210: "with snow patches",
            1213: "and a light snow",
            1216: "with snow patches",
            1219: "and snowing",
            1222: "and snowing heavily",
            1225: "with heavy snow",
            1237: "with ice pellets",
            1240: "with rain showers",
            1243: "with heavy rain showers",
            1246: "with torrential rain",
            1249: "with sleet showers",
            1252: "with heavy sleet showers",
            1255: "with snow showers",
            1258: "with heavy snow showers",
            1261: "with showers of ice pellets",
            1264: "with heavy showers of ice pellets",
            1273: "with rain and thunder",
            1276: "with heavy rain and thunder",
            1279: "with snow and thunder",
            1282: "with heavy snow and thunder",
        ]
        
        var condition = "It’s "
        
        let temperature = Session.shared.userSettings["Units"] as! Units == .metric ? self.current.tempC : self.current.tempF
        
        condition += Int(temperature) < 0 ? String(abs(Int(temperature))) + "° below zero" : String(abs(Int(temperature))) + "°"       
        condition += "\n"
        condition += customWeatherConditions[self.current.condition.code] ?? "and " + self.current.condition.text.lowercased()
        
        return condition
    }
    
    var abbreviatedCountry: String? {
        
        let countriesAbbreviations = [
            "United States of America": "USA",
            "United Kingdom": "UK",
        ]
        
        return countriesAbbreviations.keys.contains(self.location.country) ? countriesAbbreviations[self.location.country]! : nil
    }
    
    var region: String? {
        
        if self.location.region != "" && !self.location.region.contains(self.location.country) && self.location.region != self.location.name && !self.location.region.hasNonAsciiCharacters() {
            
            return self.location.region.replacingOccurrences(of: "'", with: "")
            
        } else {
            
            return nil
        }
    }
    
    var locality: String {
        
        var location = "in "
        let region = self.region != nil ? self.region! + ", " : ""
        
        location += "\(self.location.name), "
        location += "\(region)"
        location += "\(self.abbreviatedCountry ?? self.location.country)."
        
        return location
    }
    
    var localDate: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM dd yyyy"
        let localDate = Date().convert(from: TimeZone.current, to: TimeZone(identifier: self.location.tzID)!)
        
        return dateFormatter.string(from: localDate)
    }
    
    var localTime: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let localDate = Date().convert(from: TimeZone.current, to: TimeZone(identifier: self.location.tzID)!)
        
        return dateFormatter.string(from: localDate)
    }
}
