//
//  WeatherDataView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherDataView: View {
    var weatherViewModel: WeatherViewModel
    var body: some View {
        VStack {
            WeatherHeadingView(weatherViewModel: weatherViewModel)
                .padding(.bottom, 10)
            
            WeatherCoordinatesView(weatherViewModel: weatherViewModel)
            
            Divider(2)
                .padding(.bottom, 2 + 5)
            
            if weatherViewModel.wind > 0 {
                WeatherDetailsView(weatherViewModel: weatherViewModel)
                    .padding(.bottom, 15)
                
                WeatherWindView(weatherViewModel: weatherViewModel)
                    .padding(.bottom, 1 + 5)
            } else {
                WeatherDetailsView(weatherViewModel: weatherViewModel)
                    .padding(.bottom, 1 + 5)
            }
            
            Divider(2)
                .padding(.bottom, 2)
            
            WeatherDateTimeView(weatherViewModel: weatherViewModel)
            
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDataView(weatherViewModel: factory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
