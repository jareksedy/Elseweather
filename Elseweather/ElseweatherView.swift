//
//  ContentView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import SwiftUI

struct ElseweatherView: View {
    
    let randomLocationFetcher = RandomLocationFetcher()
    let weatherFetcher = WeatherFetcher()
    
    var body: some View {
        Button("Tap me!") {
            
            let location = randomLocationFetcher.fetch()
            
            guard let weather = weatherFetcher.fetch(location) else { return }

            print(weather.condition)
            print(weather.locality)
            print()
        }
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView()
    }
}
