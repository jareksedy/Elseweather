//
//  WeatherDetailsView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherDetailsView: View {
    var weatherViewModel: WeatherViewModel
    var body: some View {
        Group {
            HStack {
                if weatherViewModel.precipitation > 0 {
                    IndexView(caption: weatherViewModel.precipitationCaption,
                              value: String(weatherViewModel.precipitation),
                              units: weatherViewModel.precipitationUnits)
                }
                
                if weatherViewModel.cloudCover > 0 {
                    IndexView(caption: weatherViewModel.cloudCoverCaption,
                              value: String(weatherViewModel.cloudCover),
                              units: weatherViewModel.cloudCoverUnits)
                }
                
                if weatherViewModel.humidity > 0 {
                    IndexView(caption: weatherViewModel.humidityCaption,
                              value: String(weatherViewModel.humidity),
                              units: weatherViewModel.humidityUnits)
                }
                
                IndexView(caption: weatherViewModel.pressureCaption,
                          value: String(weatherViewModel.pressure),
                          units: weatherViewModel.pressureUnits)
                
                if weatherViewModel.uv > 1 {
                    IndexView(caption: weatherViewModel.uvCaption,
                              value: String(weatherViewModel.uv))
                }
            }
        }
    }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(weatherViewModel: weatherViewModelFactory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
