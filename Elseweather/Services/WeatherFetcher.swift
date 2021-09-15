//
//  WeatherFetcher.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

//import Foundation
//import Alamofire
//
//class WeatherFetcher {
//    
//    var apiKey: String
//    
//    init (apiKey: String) {
//        self.apiKey = apiKey
//    }
//    
//    func fetch(_ location: Location, _ completion: @escaping (WAWeather) -> ()) {
//        
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.load(location: location) { data in
//                self.parse(data: data) { weatherData in
//                    DispatchQueue.main.async {
//                        completion(weatherData)
//                    }
//                }
//            }
//        }
//    }
//    
//    fileprivate func load(location: Location, _ completion: @escaping (Data) -> ()) {
//        
//        let url = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(location.lat),\(location.lon)&aqi=yes&alerts=no"
//        
//        AF.request(url, method: .get).responseData{ response in
//            guard let data = response.data else { return }
//            completion(data)
//        }
//    }
//    
//    fileprivate func parse(data: Data, _ completion: @escaping (WAWeather) -> ()) {
//        
//        do {
//            let weatherData = try JSONDecoder().decode(WAWeather.self, from: data)
//            completion(weatherData)
//        } catch {
//            print(error)
//        }
//    }
//}
