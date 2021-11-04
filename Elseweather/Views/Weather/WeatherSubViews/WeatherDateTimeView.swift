//
//  WeatherDateTimeView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 29.09.2021.
//

import SwiftUI

struct WeatherDateTimeView: View {
    var weatherViewModel: WeatherViewModel
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(weatherViewModel.localDate) @ \(weatherViewModel.localTime)")
                        .kerning(-0.25)
                        .textStyle(SmallMonospaced())
                        .lineLimit(1)
                    
                    Divider(0)
                }
                
                VStack(alignment: .leading) {
                    Text("\(weatherViewModel.localTimeZone)")
                        .kerning(-0.25)
                        .textStyle(SmallMonospaced())
                        .lineLimit(1)
                    
                    Divider(0)
                }
            }
        }
    }
}
