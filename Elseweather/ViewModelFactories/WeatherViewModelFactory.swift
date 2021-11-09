//
//  WeatherViewModelFactory.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import Foundation
import SwiftUI

final class WeatherViewModelFactory {
    
    private let customWeatherConditions = [
        1030: "and misty",
        1063: "with patchy rain",
        1066: "with patchy snow",
        1069: "and sleet",
        1087: "with thundery outbreaks",
        1117: "and blizzard condition",
        1135: "and foggy",
        1147: "with freezing fog",
        1150: "with light drizzle",
        1153: "with light drizzle",
        1168: "with freezing drizzle",
        1171: "with freezing drizzle",
        1180: "with patchy rain",
        1183: "with light rain",
        1186: "with rain at times",
        1189: "and raining",
        1192: "with heavy rain at times",
        1195: "and raining heavily",
        1198: "with freezing rain",
        1201: "with heavy freezing rain",
        1204: "with sleet",
        1207: "with heavy sleet",
        1210: "with patchy snow",
        1213: "with light snow",
        1216: "with patchy snow",
        1219: "and snowing",
        1222: "and snowing heavily",
        1225: "with heavy snow",
        1237: "with ice pellets",
        1240: "with rain showers",
        1243: "with heavy rain showers",
        1246: "with torrential rain",
        1249: "with sleet showers",
        1252: "with heavy sleet showers",
        1255: "with snow showers",
        1258: "with heavy snow showers",
        1261: "with showers of ice pellets",
        1264: "with heavy showers of ice pellets",
        1273: "with rain and thunder",
        1276: "with heavy rain and thunder",
        1279: "with snow and thunder",
        1282: "with heavy snow and thunder",
    ]
    
    //dpKdxe4:ozoL*0xDe:kCMybvocs.R*WBs:oJxaoJWVfj sunny
    //dlH.A{ofIoWY_4W=R+WDV@ogt7j[IAWYR*ofROofWBax patchyrain
    //d3B|gJ4:00_300_3xu4.8w%MNHxu9Znh_3Ip-.00t8?v overcast
    //dNGluG_48_9ZNY%hIUjc-;%MWBIU?csobIWCIAbFxuof thundery outbreaks
    //daC%W^M{WVt7~qRjWBt6%Mt7RkfQt7t7WBV[a|ofayWB fog
    
    private let blurHashForWeatherCode = [
        0000: ["dFMakn$xx]xa0[PB%2WX4TD%o#NGpexZV@WBVqtSW=xa"], // default
        
        1000: ["d[J90+%Ls+of.AxZs,s:D%R+s-s.R+bHa|j?o#ayayay",  // sunny
               "dZN0MFozIvoL~Boea$jaI]t5t3ju9}oLovj[jIWCR,j@"], // clear
        
        1003: ["dFGcih?wtl%2Y8I;00t700IpJV=|?b56WU?GR*M|oIE2",  // partly cloudy
               "dEGl|_?^%MpI00J7YRofJn00IX=|Wn0e?b?ZWBn~IX9t"], // partly cloudy
        
        1006: ["dDJSFZ1n59WY0DDh-moJ02^g=^WXQ-?F9zI=xtIqRjxY"], // cloudy
        
        1009: ["d3B|gJ4:00_300_3xu4.8w%MNHxu9Znh_3Ip-.00t8?v",  // overcast
               "d2Cj00~qfQfQt7~q000e8w?bRjt79FACrr~q?X00t7?^"], // overcast
        
        1030: ["dxJICPM|a#of_4a}WCj[t6f6ayayRjayofayj[fkofay"], // mist
        
        1063: ["dpKdxe4:ozoL*0xDe:kCMybvocs.R*WBs:oJxaoJWVfj"], // rain patches
        1066: ["d9DA15_N_4%Mf5RiRjWB%MRjM{t7axj[RPayM_MxMxoz"], // snow patches
        1069: ["d9DA15_N_4%Mf5RiRjWB%MRjM{t7axj[RPayM_MxMxoz"], // sleet patches
        1072: ["diKd_Et7IUWBofxuRjaz~qj[RkayM{j[axj[t7WBofj["], // freezing drizzle patches
        
        1087: ["dVI5.ItRItay?wRPD%WBNGRkMxoc4mWY-;oeWDRjWAWA"], // thundery outbreaks possible
        
        1114: ["daL5RX~pIUoz-:M{R*WB?bM_WEax%Lj[t7WBxZfRt6s:"], // blowing snow
        1117: ["d9HVPL?bs;ofa#M{M{Rj~qxukCWBxvInofM{4nWBM{t7"], // blizzard
        
        1135: ["dlGSfTWBWBof~pofayf6$*ofayayWCj[ayfkWVWCfkfQ"], // fog
        1147: ["dlGSfTWBWBof~pofayf6$*ofayayWCj[ayfkWVWCfkfQ"], // freezing fog
        
        1150: ["dXKn-vt7t7kC~qayWBf6WVoff6aejZayfkkCWBayj[fk"], // patchy light drizzle
        1153: ["dTF6e0xuRjj[~qt7WBjuWBofayazIUWBj[fQxuWBayj["], // light drizzle
        1168: ["dTF6e0xuRjj[~qt7WBjuWBofayazIUWBj[fQxuWBayj["], // freezing drizzle
        1171: ["dTF6e0xuRjj[~qt7WBjuWBofayazIUWBj[fQxuWBayj["], // heavy freezing drizzle
        
        1180: ["dpKdxe4:ozoL*0xDe:kCMybvocs.R*WBs:oJxaoJWVfj"], // patchy light rain
        1183: ["dlH.A{ofIoWY_4W=R+WDV@ogt7j[IAWYR*ofROofWBax"], // light rain
        1186: ["dfD,D#M{WBoe_4RjWBoex[j]WBoLjZWBj[j[j[Rjofaz"], // moderate rain at times
        1189: ["dfD,D#M{WBoe_4RjWBoex[j]WBoLjZWBj[j[j[Rjofaz"], // moderate rain
        1192: ["drD^cARjRQj]?^RjWBj[x^axfij[bJj?j[f6WDfkj[ay"], // heavy rain at times
        1195: ["drD^cARjRQj]?^RjWBj[x^axfij[bJj?j[f6WDfkj[ay"], // heavy rain
        1198: ["dlH.A{ofIoWY_4W=R+WDV@ogt7j[IAWYR*ofROofWBax"], // light freezing rain
        1201: ["drD^cARjRQj]?^RjWBj[x^axfij[bJj?j[f6WDfkj[ay"], // moderate or heavy freezing rain
        
        1204: ["dFM%[@%ME0RQ_NM_xut7D%t7M{of-=bF%gRPkWWBRjtR"], // light sleet
        1207: ["d8K23J00_4-p00.7-pxu00%f00V[004oozV@00~qxuV?"], // moderate or heavy sleet
        
        1210: ["dsOX5rRiS5W?~VR-ozt6Iqa#t6R+NGR*Rkj[ofogaeoJ"], // patchy light snow
        1213: ["dsOX5rRiS5W?~VR-ozt6Iqa#t6R+NGR*Rkj[ofogaeoJ"], // light snow
        1216: ["dUK_:@~Aofxu02s.xZofNIENslWAt7R+IpjFRks:R+R+"], // patchy moderate snow
        1219: ["dUK_:@~Aofxu02s.xZofNIENslWAt7R+IpjFRks:R+R+"], // moderate snow
        1222: ["dEKUm900ITbd00E2$%V?00~UV@ad-.MxbvxvD*%2R*Io"], // patchy heavy snow
        1225: ["dEKUm900ITbd00E2$%V?00~UV@ad-.MxbvxvD*%2R*Io"], // heavy snow
        
        1237: ["dEKVR70000=]0000^h?F~701^%WX9a?G?aEO4ow[t7Iq"], // ice pellets
        
        1240: ["daC%W^M{WVt7~qRjWBt6%Mt7RkfQt7t7WBV[a|ofayWB"], // light rain shower
        1243: ["daC%W^M{WVt7~qRjWBt6%Mt7RkfQt7t7WBV[a|ofayWB"], // moderate or heavy rain shower
        1246: ["daC%W^M{WVt7~qRjWBt6%Mt7RkfQt7t7WBV[a|ofayWB"], // torrential rain shower
        
        1249: ["dFM%[@%ME0RQ_NM_xut7D%t7M{of-=bF%gRPkWWBRjtR"], // light sleet showers
        1252: ["d8K23J00_4-p00.7-pxu00%f00V[004oozV@00~qxuV?"], // moderate or heavy sleet showers
        
        1255: ["dsOX5rRiS5W?~VR-ozt6Iqa#t6R+NGR*Rkj[ofogaeoJ"], // light snow showers
        1258: ["dUK_:@~Aofxu02s.xZofNIENslWAt7R+IpjFRks:R+R+"], // moderate or heavy snow showers
        
        1261: ["dEKVR70000=]0000^h?F~701^%WX9a?G?aEO4ow[t7Iq"], // light showers of ice pellets
        1264: ["dEKVR70000=]0000^h?F~701^%WX9a?G?aEO4ow[t7Iq"], // moderate or heavy showers of ice pellets
        
        1273: ["dUA_hlz.tRt7uPi^oJofI9S$M{M{ROWAkCRis:jEX8W;"], // patchy rain with thunder
        1276: ["dUA_hlz.tRt7uPi^oJofI9S$M{M{ROWAkCRis:jEX8W;"], // moderate or heavy rain with thunder
        
        1279: ["dNGluG_48_9ZNY%hIUjc-;%MWBIU?csobIWCIAbFxuof"], // patchy snow with thunder
        1282: ["dNGluG_48_9ZNY%hIUjc-;%MWBIU?csobIWCIAbFxuof"], // moderate or heavy snow with thunder
    ]
    
    func construct(from weather: WAWeather) -> WeatherViewModel {
        
        var metricUnits: Bool {
            return Session.shared.useMetric
        }
        
        var displayUnits: Bool {
            return Session.shared.showUnits
        }
        
        var condition: String {
            var condition = "It’s "
            
            let temperature = metricUnits ? weather.current.tempC : weather.current.tempF
            let unitCharacter = metricUnits ? "C" : "F"
            
            condition += Int(temperature) < 0 ? "−" : ""
            
            if displayUnits {
                condition += String(abs(Int(temperature))) + " °\(unitCharacter)"
            } else {
                condition += String(abs(Int(temperature))) + "°"
            }
            
            condition += "\n"
            condition += customWeatherConditions[weather.current.condition.code] ?? "and " + weather.current.condition.text.lowercased()
            
            return condition
        }
        
        var textCondition: String {
            return customWeatherConditions[weather.current.condition.code] ?? "and " + weather.current.condition.text.lowercased()
        }
        
        var conditionCelsius: String {
            var condition = "It’s "
            let temperature = weather.current.tempC
            
            condition += Int(temperature) < 0 ? "−" : ""
            condition += String(abs(Int(temperature))) + "°"
            condition += "\n"
            condition += textCondition
            
            return condition
        }
        
        var conditionCelsiusWithUnits: String {
            var condition = "It’s "
            let temperature = weather.current.tempC
            
            condition += Int(temperature) < 0 ? "−" : ""
            condition += String(abs(Int(temperature))) + " °C"
            condition += "\n"
            condition += textCondition
            
            return condition
        }
        
        var conditionFahrenheit: String {
            var condition = "It’s "
            let temperature = weather.current.tempF
            
            condition += Int(temperature) < 0 ? "−" : ""
            condition += String(abs(Int(temperature))) + "°"
            condition += "\n"
            condition += textCondition
            
            return condition
        }
        
        var conditionFahrenheitWithUnits: String {
            var condition = "It’s "
            let temperature = weather.current.tempF
            
            condition += Int(temperature) < 0 ? "−" : ""
            condition += String(abs(Int(temperature))) + " °F"
            condition += "\n"
            condition += textCondition
            
            return condition
        }
        
        var abbreviatedCountry: String? {
            let countriesAbbreviations = [
                "United States of America": "USA",
                "United Kingdom": "UK",
            ]
            
            return countriesAbbreviations.keys.contains(weather.location.country) ? countriesAbbreviations[weather.location.country]! : nil
        }
        
        var region: String? {
            if weather.location.region != "" && !weather.location.region.contains(weather.location.country) && weather.location.region != weather.location.name && !weather.location.region.hasNonAsciiCharacters() {
                
                return weather.location.region.replacingOccurrences(of: "'", with: "")
            } else {
                return nil
            }
        }
        
        var locality: String {
            var location = ""
            let localRegion = region != nil ? region! + ", " : ""
            
            location += "\(weather.location.name), "
            location += "\(localRegion)"
            location += "\(abbreviatedCountry ?? weather.location.country)."
            
            return location
        }
        
        var localDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, MMM dd yyyy"
            let localDate = Date().convert(from: TimeZone.current, to: TimeZone(identifier: weather.location.tzID)!)
            
            return dateFormatter.string(from: localDate)
        }
        
        var localTime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let localDate = Date().convert(from: TimeZone.current, to: TimeZone(identifier: weather.location.tzID)!)
            
            return dateFormatter.string(from: localDate)
        }
        
        let code = weather.current.condition.code
        let day: Bool = weather.current.isDay == 1 ? true : false
        let dayIndex = day ? 0 : 1
        
        var bhString = ""
        
        if blurHashForWeatherCode[weather.current.condition.code]?.isEmpty == false {
            if blurHashForWeatherCode[code]!.count > 1 {
                bhString = blurHashForWeatherCode[code]![dayIndex]
            } else {
                bhString = blurHashForWeatherCode[code]![0]
            }
        } else {
            bhString =  blurHashForWeatherCode[0]![0]
        }
        
        return WeatherViewModel(location: (lat: weather.location.lat, lon: weather.location.lon),
                                conditionCelsius: conditionCelsius,
                                conditionFahrenheit: conditionFahrenheit,
                                conditionCelsiusWithUnits: conditionCelsiusWithUnits,
                                conditionFahrenheitWithUnits: conditionFahrenheitWithUnits,
                                locality: locality,
                                lat: weather.location.lat.toGeoCoordinate(),
                                lon: weather.location.lon.toGeoCoordinate(),
                                precipitationMetric: weather.current.precipMM,
                                precipitationImperial: weather.current.precipIN,
                                cloudCover: weather.current.cloud,
                                humidity: weather.current.humidity,
                                pressureMetric: weather.current.pressureMB,
                                pressureImperial: weather.current.pressureIN,
                                uv: weather.current.uv,
                                windMetric: weather.current.windKPH,
                                windImperial: weather.current.windMPH,
                                windDegree: Int(weather.current.windDegree),
                                windDirection: "\(Int(weather.current.windDegree))° \(weather.current.windDir)",
                                windGustMetric: weather.current.gustKPH,
                                windGustImperial: weather.current.gustMPH,
                                localDate: localDate.uppercased(),
                                localTime: localTime,
                                localTimeZone: weather.location.tzID.uppercased(),
                                blurHash: bhString)
    }
}
