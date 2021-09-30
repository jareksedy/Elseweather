//
//  WeatherView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherView: View {
    @State var weatherViewModel: WeatherViewModel
    @State var backgroundImage: Image
    @State private var viewBusy: Bool = false
    @State private var viewTouchedDown: Bool = false
    
    private func generateBackground(rFactor: CGFloat, punch: Float) {
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let size = CGSize(width: Int(screenWidth / rFactor), height: Int(screenHeight / rFactor))
        
        let matrix = weatherViewModel.blurHashMatrix
        let blurHash = BlurHash(components: matrix)
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let image = UIImage(blurHash: blurHash.string, size: size, punch: punch) else { return }
            DispatchQueue.main.async {
                backgroundImage = Image(uiImage: image)
            }
        }
    }
    
    private func getWeather() {
        guard let weather = weatherQueue.dequeue() else { return }
        weatherViewModel = weatherViewModelFactory.construct(from: weather)
        weatherQueue.enqueueAsync(1)
    }
    
    private func viewAppear() {
        generateBackground(rFactor: 64.0, punch: 0.75)
        getWeather()
    }
    
    private func viewTouchDown() {
        guard viewTouchedDown == false else { return }
        viewTouchedDown = true
    }
    
    private func viewTouchUp() {
        getWeather()
        generateBackground(rFactor: 24.0, punch: 0.75)
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
                        .scaledToFill())
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
        WeatherView(weatherViewModel: weatherViewModelFactory.construct(from: weatherQueue.head!), backgroundImage: Image(systemName: "circle")).preferredColorScheme(.dark)
    }
}
