//
//  WeatherHeadingView.swift
//  Elseweather
//
//  Created by Ярослав on 28.09.2021.
//

import SwiftUI

struct WeatherHeadingView: View {
    var weather: WAWeather
    var body: some View {
        HStack {
            Text(weather.condition)
                .kerning(-0.5)
                .textStyle(LargeTitle())
            Spacer()
        }
        HStack {
            Text(weather.locality)
                .kerning(-0.25)
                .textStyle(SmallTitle())
            Spacer()
        }.padding(.top, 5)
    }
}

struct WeatherHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHeadingView(weather: weatherQueue.head!).preferredColorScheme(.dark)
    }
}
