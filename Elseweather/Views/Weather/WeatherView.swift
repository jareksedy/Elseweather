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
    
    private func openInMaps() {
        let latitude: CLLocationDegrees = weatherViewModel.location.lat
        let longitude: CLLocationDegrees = weatherViewModel.location.lon
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = weatherViewModel.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    private func getWeather() {
        guard let weather = weatherQueue.dequeue() else { return }
        weatherViewModel = weatherViewModelFactory.construct(from: weather)
        weatherQueue.enqueueAsync(1)
    }
    
    private func getWeatherForCurrentLocation() {
        busyFetchingLocalWeather = true
        locationFetcher.start()
        
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
        guard busyTouchedDown == false else { return }
        busyTouchedDown = true
    }
    
    private func viewTouchUp() {
        getWeather()
        generateImage()
        busyTouchedDown = false
        displayingLocalWeather = false
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                WeatherDataView(weatherViewModel: weatherViewModel)
                    .scaleEffect(busyTouchedDown ? viewDownScale : 1.0)
                    .opacity(busyTouchedDown || busyFetchingLocalWeather ? viewDownOpacity : 1.0)
            }
            
            HStack {
//                Button(action: { openInMaps() }, label: { Image("icon-maps") })
//                    .buttonStyle(defaultControlButton())
//                    .disabled(busyTouchedDown || busyFetchingLocalWeather)
                
                Spacer()
                
                Button(action: { getWeatherForCurrentLocation() }, label: { Image("icon-pin") })
                    .buttonStyle(defaultControlButton())
                    .disabled(busyTouchedDown || busyFetchingLocalWeather || displayingLocalWeather)
                    .opacity(displayingLocalWeather ? disabledButtonOpacity : 1.0)
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
