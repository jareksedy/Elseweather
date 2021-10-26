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
    
    private let blurHashForWeatherCode = [
        0000: ["dFMakn$xx]xa0[PB%2WX4TD%o#NGpexZV@WBVqtSW=xa"], // default
        1000: ["dvN^h?5TR%j]CmoasAj[MxjbkDaxt7jbaxbHX9bFayj[",  // sunny
               "dWL4]W=@WDs._Nxtj]j[9$R-aeWVE3R*axayROjYjsfQ"], // clear
        1003: ["dFGcih?wtl%2Y8I;00t700IpJV=|?b56WU?GR*M|oIE2"], // partly cloudy
        1006: ["dBHV--Dh00V?00xZ~URkVVxuSkSiM{D%WB^+RPe,ogW?"], // cloudy
        1009: ["d4BgVx0100~W00_4%M4nHX%NEM%19ar;_4D+^*00o#_4"], // overcast
        1030: ["dXHCWVr=IAX7_N~UIBNG^+e.t7RkM{xaozWVkCWBofof"], // mist
        1063: ["dlH.A{ofIoWY_4W=R+WDV@ogt7j[IAWYR*ofROofWBax"], // rain patches
        1066: ["d*F?U[V@j[j[_NWBfQj@%gWXWBj[W;a#ayj[R*ayj[fR"], // snow patches
        1069: ["d9DA15_N_4%Mf5RiRjWB%MRjM{t7axj[RPayM_MxMxoz"], // sleet patches
        1072: ["diKd_Et7IUWBofxuRjaz~qj[RkayM{j[axj[t7WBofj["], // freezing drizzle patches
        1087: ["dNGluG_48_9ZNY%hIUjc-;%MWBIU?csobIWCIAbFxuof"], // thundery outbreaks possible
        1114: ["daL5RX~pIUoz-:M{R*WB?bM_WEax%Lj[t7WBxZfRt6s:"], // blowing snow
        1117: ["d9HVPL?bs;ofa#M{M{Rj~qxukCWBxvInofM{4nWBM{t7"], // blizzard
        1135: ["dCC?$69G00~p-;t6M{IV00xu~WD*xtM{WB-:xuRjRjt7"], // fog
        1147: ["dxLOTit7oej[~Vjuf6j[s9j[WVa|X9fPazaybHfQj@j["], // freezing fog
        1150: ["dXKn-vt7t7kC~qayWBf6WVoff6aejZayfkkCWBayj[fk"], // patchy light drizzle
        1153: ["dTF6e0xuRjj[~qt7WBjuWBofayazIUWBj[fQxuWBayj["], // light drizzle
        1168: ["dAEMOITJRpMy-@a0RPJU-UxvIobv.TS2D$rqS~.9RP-V"], // freezing drizzle
        1171: ["d7AAm*004-%300-r%LRj00Rj?bRkS@-rNEIU_MIUM{%4"], // heavy freezing drizzle !REPLACE!
        1180: ["dlH.A{ofIoWY_4W=R+WDV@ogt7j[IAWYR*ofROofWBax"], // patchy light rain
        1183: ["dwG[.xRjS2oL~pWBRjj[-;ayV@bHxbj[oLazR+j[offQ"], // light rain
        1186: ["dfD,D#M{WBoe_4RjWBoex[j]WBoLjZWBj[j[j[Rjofaz"], // moderate rain at times
        1189: ["dfD,D#M{WBoe_4RjWBoex[j]WBoLjZWBj[j[j[Rjofaz"], // moderate rain
        1192: ["d65j8t?8p0IV*0yFo#Vr4TEVjDxr4TD4VryF%%sQROMx"], // heavy rain at times
        1195: ["d65j8t?8p0IV*0yFo#Vr4TEVjDxr4TD4VryF%%sQROMx"], // heavy rain
        1198: ["d84.#vlVD#ZgzpVXNYs;QRR4cZt-PpcFnOicbungibVX"], // light freezing rain
        1201: ["d84.#vlVD#ZgzpVXNYs;QRR4cZt-PpcFnOicbungibVX"], // moderate or heavy freezing rain
        1204: ["dFM%[@%ME0RQ_NM_xut7D%t7M{of-=bF%gRPkWWBRjtR"], // light sleet
        1207: ["d8K23J00_4-p00.7-pxu00%f00V[004oozV@00~qxuV?"], // moderate or heavy sleet
        1210: ["d-M%G]o#tlRjw0WBbcaK~AWBR*n%Rkf+f+ofXTozWWkC"], // patchy light snow
        1213: ["dsOX5rRiS5W?~VR-ozt6Iqa#t6R+NGR*Rkj[ofogaeoJ"], // light snow
        1216: ["dUK_:@~Aofxu02s.xZofNIENslWAt7R+IpjFRks:R+R+"], // patchy moderate snow
        1219: ["dUK_:@~Aofxu02s.xZofNIENslWAt7R+IpjFRks:R+R+"], // moderate snow
        1222: ["dEKUm900ITbd00E2$%V?00~UV@ad-.MxbvxvD*%2R*Io"], // patchy heavy snow
        1225: ["dEKUm900ITbd00E2$%V?00~UV@ad-.MxbvxvD*%2R*Io"], // heavy snow
        1237: ["dEKVR70000=]0000^h?F~701^%WX9a?G?aEO4ow[t7Iq"], // ice pellets
        1240: ["daGJD~00%3NF_4D~V@aj-;NFV@ofWCofR%ofRkj]axoy"], // light rain shower
        1243: ["daGJD~00%3NF_4D~V@aj-;NFV@ofWCofR%ofRkj]axoy"], // moderate or heavy rain shower
        1246: ["daGJD~00%3NF_4D~V@aj-;NFV@ofWCofR%ofRkj]axoy"], // torrential rain shower
        1249: ["dFM%[@%ME0RQ_NM_xut7D%t7M{of-=bF%gRPkWWBRjtR"], // light sleet showers
        1252: ["d8K23J00_4-p00.7-pxu00%f00V[004oozV@00~qxuV?"], // moderate or heavy sleet showers
        1255: ["dsOX5rRiS5W?~VR-ozt6Iqa#t6R+NGR*Rkj[ofogaeoJ"], // light snow showers
        1258: ["dUK_:@~Aofxu02s.xZofNIENslWAt7R+IpjFRks:R+R+"], // moderate or heavy snow showers
        1261: ["dEKVR70000=]0000^h?F~701^%WX9a?G?aEO4ow[t7Iq"], // light showers of ice pellets
        1264: ["dEKVR70000=]0000^h?F~701^%WX9a?G?aEO4ow[t7Iq"], // moderate or heavy showers of ice pellets
        1273: ["dC8z$cM_p1t7pL-@WVR$J;fm%ORib{M_t8xvR:W9R%sp"], // patchy rain with thunder
        1276: ["dC8z$cM_p1t7pL-@WVR$J;fm%ORib{M_t8xvR:W9R%sp"], // moderate or heavy rain with thunder
        1279: ["d69@6j8wPB=d00?dm+TL%O+~x_R4-n%5w|XT0L-C%3WB"], // patchy snow with thunder
        1282: ["d69@6j8wPB=d00?dm+TL%O+~x_R4-n%5w|XT0L-C%3WB"], // moderate or heavy snow with thunder
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
            var location = "in "
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
        
        return WeatherViewModel(conditionCode: weather.current.condition.code,
                                location: (lat: weather.location.lat, lon: weather.location.lon),
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
