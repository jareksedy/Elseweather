//
//  WeatherDetailsView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherDetailsView: View {
    @ObservedObject var session = Session.shared
    var weatherViewModel: WeatherViewModel
    var body: some View {
        Group {
            HStack {
                if weatherViewModel.precipitationImperial > 0 {
                    IndexView(caption: weatherViewModel.precipitationCaption,
                              value: session.useMetric ? String(weatherViewModel.precipitationMetric) : String(weatherViewModel.precipitationImperial),
                              units: session.useMetric ? weatherViewModel.precipitationUnitsMetric : weatherViewModel.precipitationUnitsImperial)
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
                          value: session.useMetric ? String(weatherViewModel.pressureMetric) : String(weatherViewModel.pressureImperial),
                          units: session.useMetric ? weatherViewModel.pressureUnitsMetric : weatherViewModel.pressureUnitsImperial)
                
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
