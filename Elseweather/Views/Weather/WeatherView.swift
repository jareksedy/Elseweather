//
//  WeatherView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI
import MapKit

struct WeatherView: View {
    @State var weatherViewModel: WeatherViewModel
    @State private var displayingLocalWeather: Bool = false
    @State private var busyFetchingLocalWeather: Bool = false
    @State private var busyTouchedDown: Bool = false
    @State private var backgroundImage: Image?
    @State private var currentConditionCode: Int = 0
    @State private var isLocationAlertPresented: Bool = false
    
    private func presentLocationAlert() -> Alert {
        return Alert(
            title: Text("Location is not available"),
            message: Text("Please grant us access to your location to show current weather in your area."),
            primaryButton: .default(Text("Settings"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }),
            secondaryButton: .default(Text("No, thanks!"))
        )
    }
    
    private func getWeather() {
        guard let weather = weatherQueue.dequeue() else { return }
        weatherViewModel = weatherViewModelFactory.construct(from: weather)
        weatherQueue.enqueueAsync(1)
    }
    
    private func getWeatherForCurrentLocation() {
        locationFetcher.start()
        
        guard locationFetcher.hasAccess() else {
            isLocationAlertPresented = true
            return
        }
        
        busyFetchingLocalWeather = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let location = locationFetcher.lastKnownLocation else {
                busyFetchingLocalWeather = false
                return
            }
            
            guard let weather = weatherFetcher.fetch(location) else {
                busyFetchingLocalWeather = false
                return
            }
            
            DispatchQueue.main.async {
                weatherViewModel = weatherViewModelFactory.construct(from: weather)
                generateImage()
                busyFetchingLocalWeather = false
                displayingLocalWeather = true
            }
        }
    }
    
    private func generateImage() {
        guard Session.shared.appearance == .standard else { return }
        guard weatherViewModel.conditionCode != currentConditionCode else { return }
        
        imageGenerator.generate(string: weatherViewModel.blurHash, reducedBy: reducedByValue, punch: punchValue) { image in
            self.backgroundImage = image
            self.currentConditionCode = weatherViewModel.conditionCode
        }
    }
    
    private func viewAppear() {
        locationFetcher.start()
        generateImage()
        getWeather()
    }
    
    private func viewTouchDown() {
        guard busyTouchedDown == false else { return }
        busyTouchedDown = true
    }
    
    private func viewTouchUp() {
        getWeather()
        generateImage()
        busyTouchedDown = false
        displayingLocalWeather = false
    }
    
    private func changeSettings() {
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button(action: { changeSettings() }, label: { Image("icon-settings") })
                    .buttonStyle(defaultControlButton())
                    .padding(.top, -7)
                
                Spacer()
                
                Image("logo-small")
                    .modifier(LogoImage())
            }.padding(.top, 30)

            
            Spacer()
            
            HStack {
                WeatherDataView(weatherViewModel: weatherViewModel)
                    .scaleEffect(busyTouchedDown ? viewDownScale : 1.0)
                    .opacity(busyTouchedDown ? viewDownOpacity : 1.0)
                    .opacity(busyFetchingLocalWeather ? disabledViewOpacity : 1.0)
            }
            
            HStack {
                Spacer()
                
                Button(action: { getWeatherForCurrentLocation() }, label: { Image("icon-pin") })
                    .buttonStyle(defaultControlButton())
                    .disabled(busyTouchedDown || busyFetchingLocalWeather || displayingLocalWeather)
                    .opacity(displayingLocalWeather ? disabledButtonOpacity : 1.0)
                    .alert(isPresented: $isLocationAlertPresented) { presentLocationAlert() }
            }
        }
        .padding(25)
        .padding(.bottom, 10)
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
