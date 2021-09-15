//
//  WeatherQueue.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

//import Foundation
//
//class WeatherQueue {
//
//    init(_ length: Int) {
//        self.length = length
//        fill()
//    }
//
//    func dequeue() -> WAWeather? {
//        return count > 0 ? items.removeFirst() : nil
//    }
//
//    fileprivate var count: Int { self.items.count }
//    fileprivate var length: Int
//
//    fileprivate var items: [WAWeather] = [] {
//        didSet { fill() }
//    }
//
//    fileprivate func fill() {
//
//        while self.items.count < self.length {
//
//            weatherFetcher.fetch(randomLocationFetcher.fetch()) { weather in
//
//                self.items.append(weather)
//                print("appended!")
//            }
//        }
//    }
//}
