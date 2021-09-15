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

            let country = weather.location.country
            let region = weather.computedRegion ?? weather.location.region
            let name = weather.location.name
            
            print("\(name), \(region), \(country).")
            print(weather.conditionString)
            print()
            
        }
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView()
    }
}
