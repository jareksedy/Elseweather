//
//  WeatherView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            WeatherDataView(weatherViewModel: factory.construct(from: weatherQueue.head!))
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView().preferredColorScheme(.dark)
    }
}
