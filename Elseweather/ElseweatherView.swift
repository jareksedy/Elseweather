//
//  ContentView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import SwiftUI

struct ElseweatherView: View {
    
    let weatherQueue = WeatherQueue(length: 10)
    
    var body: some View {
        Button("Tap me!") {
            guard let weather = weatherQueue.dequeue() else { return }
            
            print(weather.condition)
            print(weather.locality)
            print()
            
            weatherQueue.enqueue(1)
        }
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView().preferredColorScheme(.dark)
    }
}
