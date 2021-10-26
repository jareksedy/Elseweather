//
//  AppSettingsService.swift
//  Elseweather
//
//  Created by Jarek Šedý on 26.10.2021.
//

import SwiftUI

class AppSettingsService {
    @ObservedObject var session = Session.shared
    private let defaults = UserDefaults.standard
    
    func storeSettings() {
        defaults.set(session.useMetric, forKey: "useMetric")
        defaults.set(session.showUnits, forKey: "showUnits")
        defaults.set(session.minimalisticAppearance, forKey: "minimalisticAppearance")
    }
    
    func loadSettings() {
        session.useMetric = defaults.bool(forKey: "useMetric")
        session.showUnits = defaults.bool(forKey: "showUnits")
        session.minimalisticAppearance = defaults.bool(forKey: "minimalisticAppearance")
    }
}
