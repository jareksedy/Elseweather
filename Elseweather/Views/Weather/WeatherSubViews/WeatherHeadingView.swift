//
//  WeatherHeadingView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherHeadingView: View {
    var weatherViewModel: WeatherViewModel
    var body: some View {
        VStack {
            HStack {
                Text(weatherViewModel.condition)
                    .kerning(-0.5)
                    .textStyle(LargeTitle())
                    //.transition(.standardHeadingText)
                    //.id(UUID())

                Spacer()
            }.padding(.bottom, 10)
            
            HStack {
                Text(weatherViewModel.locality)
                    .kerning(-0.25)
                    .textStyle(SmallTitle())
                    //.transition(.standardHeadingText)
                    //.id(UUID())
                
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
