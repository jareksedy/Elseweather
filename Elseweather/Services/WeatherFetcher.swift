//
//  WeatherFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

class WeatherFetcher {
    
    var apiKey: String
    
    init (apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetch(_ location: Location) throws -> WAWeather? {
        
        var weather: WAWeather?
        
        do { let url = URL(string: baseUrl + "?key=\(apiKey)&q=\(location.lat),\(location.lon)&aqi=no&alerts=no")
            
                    do { let data = try Data(contentsOf: url!)
                        
                        do { weather = try JSONDecoder().decode(WAWeather.self, from: data)
                            
                        } catch { throw error }
                        
                    } catch { throw error }
            
                } catch {throw error }
        
        return weather
    }
}
