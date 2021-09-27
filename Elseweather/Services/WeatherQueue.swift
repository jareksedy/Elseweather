//
//  WeatherQueue.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import SwiftUI

class WeatherQueue: ObservableObject {
    
    @Published var itemsCount: Int?
    
    let randomLocationFetcher = RandomLocationFetcher()
    let weatherFetcher = WeatherFetcher()
    
    private var items = ThreadSafeArray<WAWeather>()
    private var count: Int { self.items.valueArray.count }
    private var length: Int
    
    init(length: Int) {
        self.length = length
        enqueueSync(1)
        enqueueAsync(length - 1)
    }
    
    func enqueueSync(_ iterations: Int) {
        DispatchQueue.concurrentPerform(iterations: iterations) { _ in
            let location = self.randomLocationFetcher.fetch()
            guard let weather = self.weatherFetcher.fetch(location) else { return }
            self.items.append(weather)
            DispatchQueue.main.async {
                self.itemsCount = self.count
            }
        }
    }
    
    func enqueueAsync(_ iterations: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.concurrentPerform(iterations: iterations) { _ in
                let location = self.randomLocationFetcher.fetch()
                guard let weather = self.weatherFetcher.fetch(location) else { return }
                self.items.append(weather)
                DispatchQueue.main.async {
                    self.itemsCount = self.count
                }
            }
        }
    }
    
    func dequeue() -> WAWeather? {
        let result = count > 0 ? items.valueArray.first : nil
        
        if count > 0 { items.removeFirst() }
        itemsCount = count
        return result
    }
}
