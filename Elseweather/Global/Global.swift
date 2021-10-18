//
//  Global.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

typealias Location = (lat: Double, lon: Double)

let locationFetcher = RandomLocationFetcher()
let weatherFetcher = WeatherFetcher()

let weatherQueue = WeatherQueue(length: queueLength, locationFetcher: locationFetcher, weatherFetcher: weatherFetcher)
let weatherViewModelFactory = WeatherViewModelFactory()
let imageGenerator = ImageGenerator()
