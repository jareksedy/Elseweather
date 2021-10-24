//
//  SettingsView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 24.10.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var imperialUnits = false
    @State private var showUnits = false
    @State private var minimalisticAppearance = false
    
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
                Toggle("", isOn: $imperialUnits).toggleStyle(CustomToggleStyle(label: "Imperial units"))
            }.padding(.top, 25).padding(.bottom, 25)
            
            Divider(1).opacity(0.25)
            
            Group {
                Toggle("", isOn: $showUnits).toggleStyle(CustomToggleStyle(label: "Show temperature units"))
            }.padding(.top, 25).padding(.bottom, 25)
            
            Divider(1).opacity(0.25)
            
            Group {
                Toggle("", isOn: $minimalisticAppearance).toggleStyle(CustomToggleStyle(label: "Minimalistic appearance"))
            }.padding(.top, 25).padding(.bottom, 50)
            
            HStack {
                Text("About Elseweather")
                    .kerning(-0.5)
                    .textStyle(LargeTitle())
                
                Spacer()
            }
            
            Divider(2).opacity(settingsDividerOpacity)
            
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
