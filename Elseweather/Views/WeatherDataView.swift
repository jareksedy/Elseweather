//
//  WeatherDataView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct WeatherDataView: View {
    var weather: WAWeather
    var body: some View {
        VStack {
            WeatherHeadingView(weather: weather)
            WeatherCoordinatesView(weather: weather)
            Divider(1)
            WeatherDetailsView(weather: weather)
        }
//        VStack {
//
//
//            CoordView(lat: weather.data.location.lat, lon: weather.data.location.lon)
//                .padding(.top, 10)
//
//            WeatherDetailsView(precipitation: weather.data.current.precip_mm, cloudiness: weather.data.current.cloud, humidity: weather.data.current.humidity, pressure: weather.data.current.pressure_mb, uv: weather.data.current.uv)
//
//            weather.data.current.wind_kph > 0 ? WindView(windSpeed: weather.data.current.wind_kph, windDirection: "\(weather.data.current.wind_degree)° \(weather.data.current.wind_dir)", windGust: weather.data.current.gust_kph).padding(.top, 10) : nil
//
//
//            DateTimeView(localTime: weather.computedLocalTime, localDate: weather.computedLocalDate.uppercased(), localTimeZone: weather.data.location.tz_id)
//                .padding(.top, 2) // 26 for equal heights
//
//        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDataView(weather: weatherQueue.head!).preferredColorScheme(.dark)
    }
}
