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
            Divider(1)
            WeatherDetailsView(weatherViewModel: weatherViewModel)
            WeatherWindView(weatherViewModel: weatherViewModel)
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDataView(weatherViewModel: factory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
