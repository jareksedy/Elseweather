//
//  WeatherWindView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 29.09.2021.
//

import SwiftUI

struct WeatherWindView: View {
    @ObservedObject var session = Session.shared
    var weatherViewModel: WeatherViewModel
    var body: some View {
        Group {
            HStack {
                IndexView(caption: weatherViewModel.windCaption,
                          value: session.useMetric ? String(weatherViewModel.windMetric) : String(weatherViewModel.windImperial),
                          units: session.useMetric ? weatherViewModel.windUnitsMetric : weatherViewModel.windUnitsImperial)
                
                IndexView(caption: weatherViewModel.windDirectionCaption,
                          value: weatherViewModel.windDirection)
                
                if weatherViewModel.windGustMetric > 15.0 {
                    IndexView(caption: weatherViewModel.windGustCaption,
                              value: session.useMetric ? String(weatherViewModel.windGustMetric) : String(weatherViewModel.windGustImperial),
                              units: session.useMetric ? weatherViewModel.windGustUnitsMetric : weatherViewModel.windUnitsImperial)
                }
            }
        }
    }
}

struct WeatherWindView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWindView(weatherViewModel: weatherViewModelFactory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
