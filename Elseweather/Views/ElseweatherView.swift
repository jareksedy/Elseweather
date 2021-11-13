//
//  ElseweatherView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct ElseweatherView: View {
    @State var weatherAtStartup: WAWeather? = weatherQueue.head
    
    var body: some View {
        if apiKey == "" {
            NoAPIKeyErrorView()
        } else {
            if let weatherAtStartup = weatherAtStartup {
                WeatherView(weatherViewModel: weatherViewModelFactory.construct(from: weatherAtStartup))
            } else {
                ConnectionErrorView(weatherAtStartup: $weatherAtStartup)
            }
        }
    }
}
