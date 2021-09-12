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
            print(randomLocationFetcher.get() ?? "nil")
        }
    }
}

struct ElseweatherView_Previews: PreviewProvider {
    static var previews: some View {
        ElseweatherView()
    }
}
