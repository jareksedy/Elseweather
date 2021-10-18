//
//  WeatherQueue.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import SwiftUI

final class WeatherQueue: ObservableObject {
    
    var head: WAWeather? { return count > 0 ? items.valueArray.first : nil }
    
    private var randomLocationFetcher: RandomLocationFetcher
    private var weatherFetcher: WeatherFetcher
    
    private var items = ThreadSafeArray<WAWeather>()
    private var count: Int { self.items.valueArray.count }
    private var length: Int
    
    init(length: Int, locationFetcher: RandomLocationFetcher, weatherFetcher: WeatherFetcher) {
        self.length = length
        self.randomLocationFetcher = locationFetcher
        self.weatherFetcher = weatherFetcher
        
        enqueueSync(1)
        enqueueAsync(length - 1)
    }
    
    func enqueueSync(_ iterations: Int) {
        DispatchQueue.concurrentPerform(iterations: iterations) { _ in
            let location = self.randomLocationFetcher.fetch()
            guard let weather = self.weatherFetcher.fetch(location) else { return }
            self.items.append(weather)
        }
    }
    
    func enqueueAsync(_ iterations: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.concurrentPerform(iterations: iterations) { _ in
                let location = self.randomLocationFetcher.fetch()
                guard let weather = self.weatherFetcher.fetch(location) else { return }
                self.items.append(weather)
            }
        }
    }
    
    func dequeue() -> WAWeather? {
        let result = count > 0 ? items.removeFirst() : nil
        return result
    }
}
