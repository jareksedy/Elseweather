//
//  SettingsView.swift
//  Elseweather
//
//  Created by Ярослав on 24.10.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var metricSystem = true
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .kerning(-0.5)
                    .textStyle(LargeTitle())
                
                Spacer()
            }
            
            Divider(2).opacity(disabledButtonOpacity)
            
            HStack {
                Toggle("Metric system",
                       isOn: $metricSystem).toggleStyle(SwitchToggleStyle(tint: Color.customPrimary(for: colorScheme)))
            }.padding(.top, 25)
            
            Spacer()
        }
        .SheetCustomBackground()
        .padding(25)
        .padding(.top, 25)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().preferredColorScheme(.dark)
    }
}
