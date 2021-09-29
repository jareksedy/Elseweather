//
//  ElseweatherView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct ElseweatherView: View {
    var body: some View {
        WeatherView(weatherViewModel: factory.construct(from: weatherQueue.head!))
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView().preferredColorScheme(.dark)
    }
}
