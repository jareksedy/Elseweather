//
//  Global.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import SwiftUI

typealias Location = (lat: Double, lon: Double)

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

let locationFetcher = LocationFetcher()
let randomLocationFetcher = RandomLocationFetcher()
let weatherFetcher = WeatherFetcher()

let weatherQueue = WeatherQueue(length: queueLength, locationFetcher: randomLocationFetcher, weatherFetcher: weatherFetcher)
let weatherViewModelFactory = WeatherViewModelFactory()
let imageGenerator = ImageGenerator()
let appSettingsService = AppSettingsService()
let mapService = MapService()
