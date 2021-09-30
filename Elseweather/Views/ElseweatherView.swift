//
//  ElseweatherView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct ElseweatherView: View {
    var body: some View {
        WeatherView(weatherViewModel: weatherViewModelFactory.construct(from: weatherQueue.head!), backgroundImage: Image(systemName: "circle"))
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView().preferredColorScheme(.dark)
    }
}
