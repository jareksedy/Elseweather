//
//  WeatherHeadingView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherHeadingView: View {
    @ObservedObject var session = Session.shared
    var weatherViewModel: WeatherViewModel
    var body: some View {
        VStack {
            HStack {
                if session.useMetric {
                    if session.showUnits {
                        Text(weatherViewModel.conditionCelsiusWithUnits)
                            .kerning(-0.5)
                            .textStyle(LargeTitle())
                    } else {
                        Text(weatherViewModel.conditionCelsius)
                            .kerning(-0.5)
                            .textStyle(LargeTitle())
                    }
                } else {
                    if session.showUnits {
                        Text(weatherViewModel.conditionFahrenheitWithUnits)
                            .kerning(-0.5)
                            .textStyle(LargeTitle())
                    } else {
                        Text(weatherViewModel.conditionFahrenheit)
                            .kerning(-0.5)
                            .textStyle(LargeTitle())
                    }
                }

                Spacer()
            }.padding(.bottom, 10)
            
            HStack {
                Text(weatherViewModel.locality)
                    .kerning(-0.25)
                    .textStyle(SmallTitle())
                
                Spacer()
            }
        }
    }
}

struct WeatherHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHeadingView(weatherViewModel: weatherViewModelFactory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
