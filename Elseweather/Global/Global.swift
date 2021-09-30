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
let bhMatrixWidth = 2
let bhMatrixHeight = 4

let weatherQueue = WeatherQueue(length: queueLength)
let weatherViewModelFactory = WeatherViewModelFactory()
let blurHashGenerator = BlurHashGenerator()
