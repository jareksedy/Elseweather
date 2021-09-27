//
//  WeatherQueue.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

class WeatherQueue {
    let randomLocationFetcher = RandomLocationFetcher()
    let weatherFetcher = WeatherFetcher()
    
    private var threadSafeWeatherArray = ThreadSafeArray<WAWeather>()
    private var count: Int { self.threadSafeWeatherArray.valueArray.count }
    private var length: Int
    
    init(length: Int) {
        self.length = length
        enqueue(length)
    }
    
    func enqueue(_ iterations: Int) {
        DispatchQueue.concurrentPerform(iterations: iterations) { _ in
            let location = randomLocationFetcher.fetch()
            guard let weather = weatherFetcher.fetch(location) else { return }
            threadSafeWeatherArray.append(weather)
        }
    }
    
    func dequeue() -> WAWeather? {
        let result = count > 0 ? threadSafeWeatherArray.valueArray.first : nil
        threadSafeWeatherArray.removeFirst()
        return result
    }
}
