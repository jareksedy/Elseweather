//
//  NoAPIKeyErrorView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 13.11.2021.
//

import SwiftUI

struct NoAPIKeyErrorView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("logo-tiny").modifier(LogoImage())
                
                Spacer()
                
            }.padding(.top, 35)

            Spacer()
            
            VStack {
                HStack {
                    Text("No API key found")
                        .kerning(-0.5)
                        .textStyle(LargeTitle())
                    
                    Spacer()
                }.padding(.bottom, 10)
                
                HStack {
                    Text("Please register at weatherapi.com and obtain a free API key.\n\nPut your API key in\n/Config/Config.swift.")
                        .kerning(-0.25)
                        .textStyle(SmallTitle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Spacer()
        }
        .padding(25)
        .padding(.bottom, 15)
        .background(Color.customBackground(for: colorScheme))
        .ignoresSafeArea(.all)
    }
}
