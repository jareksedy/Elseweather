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
    @State private var backgroundImage = Image(systemName: "cross")
    
    private func getWeather() {
        guard let weather = weatherQueue.dequeue() else { return }
        weatherViewModel = weatherViewModelFactory.construct(from: weather)
        weatherQueue.enqueueAsync(1)
    }
    
    private func viewAppear() {
        blurHashGenerator.generateImage(components: weatherViewModel.blurHashMatrix, reducedBy: 24.0, punch: 0.75) { image in
            self.backgroundImage = image
        }
        getWeather()
    }
    
    private func viewTouchDown() {
        guard viewTouchedDown == false else { return }
        viewTouchedDown = true
    }
    
    private func viewTouchUp() {
        getWeather()
        blurHashGenerator.generateImage(components: weatherViewModel.blurHashMatrix, reducedBy: 24.0, punch: 0.75) { image in
            self.backgroundImage = image
        }
        viewTouchedDown = false
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            WeatherDataView(weatherViewModel: weatherViewModel)
                .scaleEffect(viewTouchedDown ? 0.975 : 1.0)
                .opacity(viewTouchedDown ? 0.75 : 1.0)
        }
        .padding(25)
        .padding(.bottom, 50)
        .background(backgroundImage
                        .resizable()
                        .scaledToFill()
                        .transition(.slide)
                        .animation(.linear(duration: 1.0)))
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
