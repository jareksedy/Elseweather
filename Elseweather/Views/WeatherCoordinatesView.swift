//
//  WeatherCoordinatesView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherCoordinatesView: View {
    var weather: WAWeather
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text("LAT. \(weather.location.lat.toGeoCoordinate())")
                        .kerning(-0.25)
                        .textStyle(SmallMonospaced())

                    Divider(0)
                }
                
                VStack(alignment: .leading) {
                    Text("LON. \(weather.location.lon.toGeoCoordinate())")
                        .kerning(-0.25)
                        .textStyle(SmallMonospaced())
                    
                    Divider(0)
                }
            }
        }
    }
}

struct WeatherCoordinatesView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCoordinatesView(weather: weatherQueue.head!).preferredColorScheme(.dark)
    }
}
