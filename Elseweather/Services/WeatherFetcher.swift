//
//  WeatherFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

class WeatherFetcher {
    
    func fetch(_ location: Location) -> WAWeather? {
        
        var weather: WAWeather?
        
        guard let url = URL(string: Session.shared.baseUrl +
                                "?key=\(Session.shared.apiKey)&q=\(location.lat),\(location.lon)&aqi=no&alerts=no") else { return nil }
        
        do { let data = try Data(contentsOf: url)
            
            do { weather = try JSONDecoder().decode(WAWeather.self, from: data)
                
            } catch { print(error) }
            
        } catch { print(error) }
        
        return weather
    }
}
