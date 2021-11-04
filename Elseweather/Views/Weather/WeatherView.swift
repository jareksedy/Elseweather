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
    
    @State private var currentConditionCode: Int = 0
    
    @State private var isLocationAlertPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    
    @State private var timer = Timer.publish(every: continuousModeInterval, tolerance: 0.25, on: .main, in: .common).autoconnect()
    
    // MARK: - Private methods.
    
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
            timer.upstream.connect().cancel()
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
    
    private func viewTap() {
        guard inContinuousMode == false else { return }
        guard busyFetchingLocalWeather == false else { return }
        
        getWeather()
        generateImage()
        displayingLocalWeather = false
    }
    
    // MARK: - View body.
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Toggle("", isOn: $isSettingsPresented)
                    .toggleStyle(SettingsToggleStyle(onColor: .customPrimary(for: colorScheme), offColor: Color.clear))
                    .sheet(isPresented: $isSettingsPresented) { SettingsView() }
                
                Spacer()
//                Divider(2)
//                Image("logo-tiny").modifier(LogoImage())
            }.padding(.top, 25)
            
            
            Spacer()
            
            WeatherDataView(weatherViewModel: weatherViewModel)
                .opacity(busyFetchingLocalWeather ? disabledViewOpacity : 1.0)
                .padding(.bottom, 15)
            
            HStack {
                Button(action: {
                    getWeatherForCurrentLocation()
                }, label: {
                    Image(displayingLocalWeather ? "button-location-pressed" : "button-location")
                })
                    .buttonStyle(LocationButton(displayingLocalWeather))
                    .disabled(busyFetchingLocalWeather || displayingLocalWeather || inContinuousMode)
                    .opacity(inContinuousMode || busyFetchingLocalWeather ? disabledButtonOpacity : 1.0)
                    .alert(isPresented: $isLocationAlertPresented) { presentLocationAlert() }
                
                Button(action: {
                    inContinuousMode.toggle()
                    
                    if inContinuousMode {
                        UIApplication.shared.isIdleTimerDisabled = true
                        timer = Timer.publish(every: continuousModeInterval,
                                              tolerance: 0.25,
                                              on: .main,
                                              in: .common).autoconnect()
                    } else {
                        UIApplication.shared.isIdleTimerDisabled = false
                        timer.upstream.connect().cancel()
                    }
                }, label: {
                    Image(inContinuousMode ? "button-stop" : "button-play")
                })
                    .buttonStyle(PlayButton(inContinuousMode: $inContinuousMode))
                    .disabled(busyFetchingLocalWeather)
                    .opacity(busyFetchingLocalWeather ? disabledButtonOpacity : 1.0)
                
                Button(action: {
                    inContinuousMode = false
                    getWeather()
                    generateImage()
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
        .onTapGesture {
            viewTap()
        }
    }
}
