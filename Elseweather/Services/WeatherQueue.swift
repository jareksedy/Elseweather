//
//  WeatherQueue.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import SwiftUI

class WeatherQueue: ObservableObject {
    
    @Published var pubCount: Int?
    
    let randomLocationFetcher = RandomLocationFetcher()
    let weatherFetcher = WeatherFetcher()
    
    private var threadSafeWeatherArray = ThreadSafeArray<WAWeather>()
    private var count: Int { self.threadSafeWeatherArray.valueArray.count }
    private var length: Int
    
    init(length: Int) {
        self.length = length
        enqueueMain(1)
        enqueue(length)
    }
    
    func enqueueMain(_ iterations: Int) {
        DispatchQueue.concurrentPerform(iterations: iterations) { _ in
            let location = self.randomLocationFetcher.fetch()
            guard let weather = self.weatherFetcher.fetch(location) else { return }
            self.threadSafeWeatherArray.append(weather)
            DispatchQueue.main.async {
                self.pubCount = self.count
            }
        }
    }
    
    func enqueue(_ iterations: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.concurrentPerform(iterations: iterations) { _ in
                let location = self.randomLocationFetcher.fetch()
                guard let weather = self.weatherFetcher.fetch(location) else { return }
                self.threadSafeWeatherArray.append(weather)
                DispatchQueue.main.async {
                    self.pubCount = self.count
                }
            }
        }
    }
    
    func dequeue() -> WAWeather? {
        let result = count > 0 ? threadSafeWeatherArray.valueArray.first : nil
        
        if count > 0 {
            threadSafeWeatherArray.removeFirst()
        }
        pubCount = count
        return result
    }
}
