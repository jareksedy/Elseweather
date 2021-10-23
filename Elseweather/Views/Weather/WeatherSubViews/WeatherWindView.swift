//
//  WeatherWindView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 29.09.2021.
//

import SwiftUI

struct WeatherWindView: View {
    var weatherViewModel: WeatherViewModel
    var body: some View {
        Group {
            HStack {
                IndexView(caption: weatherViewModel.windCaption,
                          value: String(weatherViewModel.wind),
                          units: weatherViewModel.windUnits)
                
                IndexView(caption: weatherViewModel.windDirectionCaption,
                          value: weatherViewModel.windDirection)
                
                if weatherViewModel.windGust > 10.0 {
                    IndexView(caption: weatherViewModel.windGustCaption,
                              value: String(weatherViewModel.windGust),
                              units: weatherViewModel.windGustUnits)
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
