//
//  ErrorView.swift
//  Elseweather
//
//  Created by Ярослав on 13.11.2021.
//

import SwiftUI

struct ErrorView: View {
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
                    Text("Cannot connect to weather server")
                        .kerning(-0.5)
                        .textStyle(LargeTitle())
                    
                    Spacer()
                }.padding(.bottom, 10)
                
                HStack {
                    Text("Poor Internet connection or weather server is down. Try again.")
                        .kerning(-0.25)
                        .textStyle(SmallTitle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    Button(action: {
                        print("hello!")
                    }, label: { Text("Retry") })
                        .buttonStyle(RetryButton())
                }.padding(.top, 35)
            }
            
            Spacer()
        }
        .padding(25)
        .padding(.bottom, 15)
        .background(Color.customErrorBackground(for: colorScheme))
        .ignoresSafeArea(.all)
    }
}
