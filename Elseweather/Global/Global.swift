//
//  Global.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

typealias Location = (lat: Double, lon: Double)

typealias BlurHashComponent = (Float, Float, Float)
typealias BlurHashVector = [BlurHashComponent]
typealias BlurHashMatrix = [BlurHashVector]

let queueLength = 10

let weatherQueue = WeatherQueue(length: queueLength)
let factory = WeatherViewModelFactory()
