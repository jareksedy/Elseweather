//
//  Extensions.swift
//  Elseweather
//
//  Created by Jarek Šedý on 15.09.2021.
//

import Foundation
import SwiftUI

extension String {
    func hasNonAsciiCharacters() -> Bool {
        return self.unicodeScalars.filter{ $0.isASCII == false } == [] ? false : true
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toGeoCoordinate() -> String {
        let loc = Int(self)
        let reminder = Int(self.truncatingRemainder(dividingBy: 1) * 100)
        return String(loc) + "° " + String(abs(reminder)) + "′"
    }
}

extension Date {
    func convert(from initTimeZone: TimeZone, to targetTimeZone: TimeZone) -> Date {
        let delta = TimeInterval(targetTimeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension Color {
    static let customDarkPrimary = Color(UIColor(red: 0.98, green: 0.95, blue: 0.87, alpha: 1.00))
    static let customDarkBackground = Color(UIColor(red: 0.13, green: 0.14, blue: 0.15, alpha: 1.00))
    
    static let customLightPrimary = customDarkBackground
    static let customLightBackground = customDarkPrimary
    
    static let customDarkSecondary = Color(UIColor(red: 0.56, green: 0.55, blue: 0.51, alpha: 1.00))
    static let customLightSecondary = Color(UIColor(red: 0.55, green: 0.55, blue: 0.51, alpha: 1.00))
    
    static func customPrimary(for scheme: ColorScheme) -> Color {
        if scheme == .dark {
            return customDarkPrimary
        } else {
            return customLightPrimary
        }
    }
    
    static func customSecondary(for scheme: ColorScheme) -> Color {
        if scheme == .dark {
            return customDarkSecondary
        } else {
            return customLightSecondary
        }
    }
    
    static func customBackground(for scheme: ColorScheme) -> Color {
        if scheme == .dark {
            return customDarkBackground
        } else {
            return customLightBackground
        }
    }
}
