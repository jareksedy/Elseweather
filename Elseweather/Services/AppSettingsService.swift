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
    
    private func isKeyPresent(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
    
    func storeSettings() {
        defaults.set(session.useMetric, forKey: "useMetric")
        defaults.set(session.showUnits, forKey: "showUnits")
        defaults.set(session.minimalisticAppearance, forKey: "minimalisticAppearance")
    }
    
    func loadSettings() {
        session.useMetric = isKeyPresent(key: "useMetric") ? defaults.bool(forKey: "useMetric") : true
        session.showUnits = isKeyPresent(key: "showUnits") ? defaults.bool(forKey: "showUnits") : false
        session.minimalisticAppearance = isKeyPresent(key: "minimalisticAppearance") ? defaults.bool(forKey: "minimalisticAppearance") : false
    }
}
