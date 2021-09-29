//
//  WeatherView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherView: View {
    @State var weatherViewModel: WeatherViewModel
    @State private var viewBusy: Bool = false
    
    private func getWeather() {
        guard let weather = weatherQueue.dequeue() else { return }
        weatherViewModel = factory.construct(from: weather)
        weatherQueue.enqueueAsync(1)
    }
    
    private func viewAppear() {
        getWeather()
    }
    
    private func viewTap() {
        getWeather()
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            WeatherDataView(weatherViewModel: weatherViewModel)
        }
        .padding(25)
        .padding(.bottom, 50)
        .background(Color.blue)
        .ignoresSafeArea(.all)
        .transition(.standard)
        .animation(.standard)
        .onAppear {
            viewAppear()
        }
        .onTapGesture {
            viewTap()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherViewModel: factory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
