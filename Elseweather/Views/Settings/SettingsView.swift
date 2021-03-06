//
//  SettingsView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 24.10.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var session = Session.shared
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .kerning(-0.5)
                    .textStyle(LargeTitle())
                
                Spacer()
            }
            
            Divider(2).opacity(settingsDividerOpacity)
            
            Group {
                Toggle("", isOn: $session.useMetric)
                    .onChange(of: session.useMetric) { value in
                        appSettingsService.storeSettings()
                    }
                    .toggleStyle(CustomToggleStyle(label: "Metric System",
                                                   onColor: .customSecondary(for: colorScheme),
                                                   offColor: .customBackground(for: colorScheme),
                                                   thumbColor: colorScheme == .dark ? .customPrimary(for: colorScheme) : .customBackground(for: colorScheme)))
            }.padding(.top, 25).padding(.bottom, 10)
            
            Group {
                Toggle("", isOn: $session.showUnits)
                    .onChange(of: session.showUnits) { value in
                        appSettingsService.storeSettings()
                    }
                    .toggleStyle(CustomToggleStyle(label: "Show Temperature Units",
                                                   onColor: .customSecondary(for: colorScheme),
                                                   offColor: .customBackground(for: colorScheme),
                                                   thumbColor: colorScheme == .dark ? .customPrimary(for: colorScheme) : .customBackground(for: colorScheme)))
            }.padding(.top, 10).padding(.bottom, 10)
            
            Group {
                Toggle("", isOn: $session.minimalisticAppearance)
                    .onChange(of: session.minimalisticAppearance) { value in
                        appSettingsService.storeSettings()
                    }
                    .toggleStyle(CustomToggleStyle(label: "Minimalistic Appearance",
                                                   onColor: .customSecondary(for: colorScheme),
                                                   offColor: .customBackground(for: colorScheme),
                                                   thumbColor: colorScheme == .dark ? .customPrimary(for: colorScheme) : .customBackground(for: colorScheme)))
            }.padding(.top, 10).padding(.bottom, 25)
            
            Divider(2).opacity(settingsDividerOpacity)
            
            HStack {
                Text("""
                     Elseweather v.\(Session.shared.version) by Jarek Šedý. Open source. Distributed under MIT license at https://github.com/jareksedy/elseweather
                     
                     Contact me at <jareksedy@icloud.com>.
                     """.uppercased())
                    .kerning(-0.25)
                    .textStyle(SmallMonospaced())
                    .opacity(0.5)
                
                Spacer()
            }.padding(.top, 10)
            
            
            Spacer()
        }
        .SheetCustomBackground()
        .padding(25)
        .padding(.top, 25)
    }
}
