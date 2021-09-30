//
//  WeatherCoordinatesView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherCoordinatesView: View {
    var weatherViewModel: WeatherViewModel
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Divider(0)
                    
                    Text("LAT. \(weatherViewModel.lat)")
                        .kerning(-0.25)
                        .textStyle(SmallMonospaced())
                }
                
                VStack(alignment: .leading) {
                    Divider(0)
                    
                    Text("LON. \(weatherViewModel.lon)")
                        .kerning(-0.25)
                        .textStyle(SmallMonospaced())
                }
            }
        }
    }
}

struct WeatherCoordinatesView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCoordinatesView(weatherViewModel: weatherViewModelFactory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
