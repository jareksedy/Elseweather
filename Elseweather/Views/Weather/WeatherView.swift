//
//  WeatherView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI
import MapKit

struct WeatherView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var weatherViewModel: WeatherViewModel
    @State private var backgroundImage: Image?
    
    @State private var displayingLocalWeather: Bool = false
    @State private var inContinuousMode: Bool = false
    
    @State private var busyFetchingLocalWeather: Bool = false
    @State private var busyTouchedDown: Bool = false
    
    @State private var currentConditionCode: Int = 0
    
    @State private var isLocationAlertPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    
    private let timer = Timer.publish(every: continuousModeInterval, on: .main, in: .common).autoconnect()
    
    private func presentLocationAlert() -> Alert {
        return Alert(
            title: Text("Location is not available"),
            message: Text("Please grant access to your location to show current weather in your area."),
            primaryButton: .default(Text("Settings"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }),
            secondaryButton: .default(Text("No, thanks!"))
        )
    }
    
    private func openInMaps() {
        let latitude: CLLocationDegrees = weatherViewModel.location.lat
        let longitude: CLLocationDegrees = weatherViewModel.location.lon
        let regionDistance:CLLocationDistance = 10_000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates,
                                            latitudinalMeters: regionDistance,
                                            longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = weatherViewModel.locality
        mapItem.openInMaps(launchOptions: options)
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
                inContinuousMode = false
            }
        }
    }
    
    private func generateImage() {
        //guard Session.shared.minimalisticAppearance == false else { return }
        guard weatherViewModel.conditionCode != currentConditionCode else { return }
        
        imageGenerator.generate(string: weatherViewModel.blurHash, reducedBy: reducedByValue, punch: punchValue) { image in
            self.backgroundImage = image
            self.currentConditionCode = weatherViewModel.conditionCode
        }
    }
    
    private func runContinuousMode() {
        guard inContinuousMode == true else {
            UIApplication.shared.isIdleTimerDisabled = false
            return
        }
        getWeather()
        generateImage()
        displayingLocalWeather = false
    }
    
    private func viewAppear() {
        appSettingsService.loadSettings()
        locationFetcher.start()
        generateImage()
        getWeather()
    }
    
    private func viewTouchDown() {
        guard inContinuousMode == false else { return }
        guard busyTouchedDown == false else { return }
        guard busyFetchingLocalWeather == false else { return }
        busyTouchedDown = true
    }
    
    private func viewTouchUp() {
        guard inContinuousMode == false else { return }
        guard busyFetchingLocalWeather == false else { return }
        
        getWeather()
        generateImage()
        busyTouchedDown = false
        displayingLocalWeather = false
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Toggle("", isOn: $isSettingsPresented)
                    .toggleStyle(SettingsToggleStyle(onColor: .customPrimary(for: colorScheme), offColor: Color.clear))
                    .sheet(isPresented: $isSettingsPresented) { SettingsView() }
                
                Divider(2)
                
                Image("logo-tiny").modifier(LogoImage())
            }.padding(.top, 35)
            
            
            Spacer()
            
            WeatherDataView(weatherViewModel: weatherViewModel)
                .scaleEffect(busyTouchedDown ? viewDownScale : 1.0)
                .opacity(busyFetchingLocalWeather ? disabledViewOpacity : 1.0)
                .padding(.bottom, 15)
            
            HStack {
                Button(action: {
                    getWeatherForCurrentLocation()
                }, label: {
                    Image(displayingLocalWeather ? "button-location-pressed" : "button-location")
                })
                    .buttonStyle(LocationButton(displayingLocalWeather))
                    .disabled(busyTouchedDown || busyFetchingLocalWeather || displayingLocalWeather || inContinuousMode)
                    .opacity(inContinuousMode || busyFetchingLocalWeather ? disabledButtonOpacity : 1.0)
                    .alert(isPresented: $isLocationAlertPresented) { presentLocationAlert() }
                
                Button(action: {
                    inContinuousMode.toggle()
                    UIApplication.shared.isIdleTimerDisabled = true
                }, label: {
                    Image(inContinuousMode ? "button-pause" : "button-play")
                })
                    .buttonStyle(PlayButton())
                    .disabled(busyFetchingLocalWeather)
                    .opacity(busyFetchingLocalWeather ? disabledButtonOpacity : 1.0)
                
                Button(action: {
                    inContinuousMode = false
                    getWeather()
                    generateImage()
                    busyTouchedDown = false
                    displayingLocalWeather = false
                }, label: {
                    Image("button-next")
                })
                    .buttonStyle(NextButton())
                    .disabled(busyFetchingLocalWeather)
                    .opacity(busyFetchingLocalWeather ? disabledButtonOpacity : 1.0)
                
                Button(action: {
                    openInMaps()
                }, label: {
                    Image("button-maps")
                })
                    .buttonStyle(MapsButton())
                    .disabled(inContinuousMode)
                    .opacity(inContinuousMode ? disabledButtonOpacity : 1.0)
            }
        }
        .padding(25)
        .padding(.bottom, 15)
        .background(BackgroundView(backgroundImage: backgroundImage))
        .ignoresSafeArea(.all)
        .transition(.standard)
        .animation(.standard)
        .onAppear { viewAppear() }
        .onReceive(timer) { _ in runContinuousMode() }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in viewTouchDown()}
                .onEnded { _ in viewTouchUp()}
        )
    }
}

//
//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView(weatherViewModel: weatherViewModelFactory.construct(from: weatherQueue.head!)).preferredColorScheme(.dark)
//    }
//}
