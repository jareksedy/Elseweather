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
            
            guard let weather = weatherFetcher.fetch(randomLocationFetcher.fetch()) else { return }

            let country = weather.location.country
            let region = weather.location.region
            let name = weather.location.name
            
            print("\(name), \(region), \(country).")
            
        }
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView()
    }
}
