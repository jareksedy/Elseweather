//
//  ContentView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import SwiftUI

struct ElseweatherView: View {
    var body: some View {
        Button("Tap me!") {
            
            guard let weather = weatherQueue.dequeue() else {

                print("Not yet ready!")
                return

            }

            print("\(weather.location.name), \(weather.location.region), \(weather.location.country).")
            
        }
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView()
    }
}
