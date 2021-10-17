//
//  Global.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation
import SwiftUI

typealias Location = (lat: Double, lon: Double)

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

let queueLength = 10
let bhMatrixWidth = 2
let bhMatrixHeight = 4

let weatherQueue = WeatherQueue(length: queueLength)
let weatherViewModelFactory = WeatherViewModelFactory()
let blurHashImageGenerator = BlurHashImageGenerator()
