//
//  BackgroundView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 19.10.2021.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var session = Session.shared
    var backgroundImage: Image?
    
    var body: some View {
        
        if session.minimalisticAppearance {
            Color.customBackground(for: colorScheme)
        } else {
            backgroundImage?
                .resizable()
                .scaledToFill()
                .opacity(colorScheme == .dark ? backgroundOpacityDark : backgroundOpacityLight)
                .transition(.standardBackground)
                .id(UUID())
        }
    }
}
