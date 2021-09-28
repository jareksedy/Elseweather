//
//  WeatherDetailsView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherDetailsView: View {
    var weather: WAWeather
    var body: some View {
        HStack {
            
            precipitation != nil && precipitation! > 0.0 ? ConditionView(caption: "PRECIPITATION", value: String(precipitation!), unit: "MM") : nil
            
            cloudiness != nil && cloudiness! > 0 ? ConditionView(caption: "CLOUD COVER", value: String(cloudiness!), unit: "%") : nil
            
            humidity != nil && humidity! > 0 ? ConditionView(caption: "HUMIDITY", value: String(humidity!), unit: "%") : nil
            
            ConditionView(caption: "PRESSURE", value: String(Int(pressure)), unit: "MBAR")
            
            uv > 1 ? ConditionView(caption: "UV", value: String(Int(uv))) : nil
        }
    }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(weather: weatherQueue.head!).preferredColorScheme(.dark)
    }
}
