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
    @State private var viewTouchedDown: Bool = false
    @State private var backgroundImage: Image?
    
    private func getWeather() {
        guard let weather = weatherQueue.dequeue() else { return }
        weatherViewModel = weatherViewModelFactory.construct(from: weather)
        weatherQueue.enqueueAsync(1)
    }
    
    private func getWeatherForCurrentLocation() {
        viewBusy = true
        
        guard let location = locationFetcher.lastKnownLocation else {
            viewBusy = false
            return
        }
        
        guard let weather = weatherFetcher.fetch(location) else {
            viewBusy = false
            return
        }
        
        weatherViewModel = weatherViewModelFactory.construct(from: weather)
        
        viewBusy = false
    }
    
    private func generateImage() {
        guard Session.shared.appearance == .standard else { return }
        imageGenerator.generate(string: weatherViewModel.blurHash, reducedBy: reducedByValue, punch: punchValue) { image in
            self.backgroundImage = image
        }
    }
    
    private func viewAppear() {
        locationFetcher.start()
        generateImage()
        getWeather()
    }
    
    private func viewTouchDown() {
        guard viewTouchedDown == false else { return }
        viewTouchedDown = true
    }
    
    private func viewTouchUp() {
        getWeather()
        generateImage()
        viewTouchedDown = false
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                WeatherDataView(weatherViewModel: weatherViewModel)
                    .scaleEffect(viewTouchedDown ? viewDownScale : 1.0)
                    .opacity(viewTouchedDown || viewBusy ? viewDownOpacity : 1.0)
            }
            
            HStack {
                Spacer()
                
                Button(action: { getWeatherForCurrentLocation() }, label: { Image("icon-pin") })
                    .buttonStyle(defaultControlButton())
                    .disabled(viewTouchedDown || viewBusy)
                    .opacity(viewTouchedDown || viewBusy ? viewDownOpacity : 1.0)
            }
        }
        .padding(25)
        .padding(.bottom, 25)
        .background(BackgroundView(backgroundImage: backgroundImage))
        .ignoresSafeArea(.all)
        .transition(.standard)
        .animation(.standard)
        .onAppear {
            viewAppear()
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in viewTouchDown()}
                .onEnded { _ in viewTouchUp()}
        )
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherViewModel: weatherViewModelFactory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
    }
}
