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
            
            WeatherCoordinatesView(weatherViewModel: weatherViewModel)
                .padding(.bottom, 3)
            
            Divider(2)
            
            WeatherDetailsView(weatherViewModel: weatherViewModel)
                .padding(.top, 3)
            
            WeatherWindView(weatherViewModel: weatherViewModel)
                .padding(.top, 10)
                .padding(.bottom, 3)
            
            Divider(2)
            
            WeatherDateTimeView(weatherViewModel: weatherViewModel)
                .padding(.top, 3)
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDataView(weatherViewModel: factory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
