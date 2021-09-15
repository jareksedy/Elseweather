//
//  WeatherFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

class WeatherFetcher {
    
    func fetch(_ location: Location) -> WAWeather? {
        
        let instance = Session.shared
        
        var weather: WAWeather?
        
        let url = URL(string: instance.baseUrl + "?key=\(instance.apiKey)&q=\(location.lat),\(location.lon)&aqi=no&alerts=no")
        
        do { let data = try Data(contentsOf: url!)
            
            do { weather = try JSONDecoder().decode(WAWeather.self, from: data)
                
            } catch { print(error) }
            
        } catch { print(error) }
        
        return weather
    }
}
