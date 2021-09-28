//
//  Global.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import Foundation

typealias Location = (lat: Double, lon: Double)

let weatherQueue = WeatherQueue(length: 10)
