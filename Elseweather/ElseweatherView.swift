//
//  ContentView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 12.09.2021.
//

import SwiftUI

struct ElseweatherView: View {
    
    let randomLocationFetcher = RandomLocationFetcher()
    
    var body: some View {
        Button("Tap me!") {
            
            print(randomLocationFetcher.fetch())
            
        }
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView()
    }
}
