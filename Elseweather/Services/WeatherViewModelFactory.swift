//
//  WeatherViewModelFactory.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import Foundation

final class WeatherViewModelFactory {
    func construct(from weather: WAWeather) -> WeatherViewModel {
        var metricUnits: Bool {
            return Session.shared.units == .metric
        }
        
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
            
            let temperature = metricUnits ? weather.current.tempC : weather.current.tempF
            
            condition += Int(temperature) < 0 ? String(abs(Int(temperature))) + "° below zero" : String(abs(Int(temperature))) + "°"
            condition += "\n"
            condition += customWeatherConditions[weather.current.condition.code] ?? "and " + weather.current.condition.text.lowercased()
            
            return condition
        }
        
        var abbreviatedCountry: String? {
            let countriesAbbreviations = [
                "United States of America": "USA",
                "United Kingdom": "UK",
            ]
            
            return countriesAbbreviations.keys.contains(weather.location.country) ? countriesAbbreviations[weather.location.country]! : nil
        }
        
        var region: String? {
            if weather.location.region != "" && !weather.location.region.contains(weather.location.country) && weather.location.region != weather.location.name && !weather.location.region.hasNonAsciiCharacters() {
                
                return weather.location.region.replacingOccurrences(of: "'", with: "")
            } else {
                return nil
            }
        }
        
        var locality: String {
            var location = "in "
            let localRegion = region != nil ? region! + ", " : ""
            
            location += "\(weather.location.name), "
            location += "\(localRegion)"
            location += "\(abbreviatedCountry ?? weather.location.country)."
            
            return location
        }
        
        var localDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, MMM dd yyyy"
            let localDate = Date().convert(from: TimeZone.current, to: TimeZone(identifier: weather.location.tzID)!)
            
            return dateFormatter.string(from: localDate)
        }
        
        var localTime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let localDate = Date().convert(from: TimeZone.current, to: TimeZone(identifier: weather.location.tzID)!)
            
            return dateFormatter.string(from: localDate)
        }
        
        return WeatherViewModel(condition: condition,
                                locality: locality,
                                lat: weather.location.lat.toGeoCoordinate(),
                                lon: weather.location.lon.toGeoCoordinate(),
                                precipitation: metricUnits ? weather.current.precipMM : weather.current.precipIN,
                                precipitationUnits: metricUnits ? "MM" : "″",
                                cloudCover: weather.current.cloud,
                                cloudCoverUnits: "%",
                                humidity: weather.current.humidity,
                                humidityUnits: "%",
                                pressure: metricUnits ? Double(weather.current.pressureMB) : weather.current.pressureIN,
                                pressureUnits: metricUnits ? "MBAR" : "″",
                                uv: weather.current.uv,
                                wind: metricUnits ? weather.current.windKPH : weather.current.windMPH,
                                windUnits: metricUnits ? "KPH" : "MPH",
                                windDegree: weather.current.windDegree,
                                windDirection: weather.current.windDir,
                                windGust: metricUnits ? weather.current.gustKPH : weather.current.gustMPH,
                                windGustUnits: metricUnits ? "KPH" : "MPH",
                                localDate: localDate.uppercased(),
                                localTime: localTime,
                                localTimeZone: weather.location.tzID)
    }
}
