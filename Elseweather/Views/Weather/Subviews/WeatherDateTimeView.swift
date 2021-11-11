//
//  WeatherDateTimeView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 29.09.2021.
//

import SwiftUI

struct WeatherDateTimeView: View {
    @ObservedObject var session = Session.shared
    var weatherViewModel: WeatherViewModel
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(session.useMetric ? weatherViewModel.localDate : weatherViewModel.localDateUS) @ \(weatherViewModel.localTime)")
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
