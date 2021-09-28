//
//  ViewStyles.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct Divider: View {
    let color: Color = .primary
    var width: CGFloat
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
    init(_ width: CGFloat) {
        self.width = width
    }
}

/* Button Styles */

struct btStyleScaled: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(Color.primary)
            .animation(.spring(response: 0.4, dampingFraction: 0.6))
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
    }
}

struct btStyleScaledBigger: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 24))
            .foregroundColor(Color.primary)
            .animation(.spring(response: 0.4, dampingFraction: 0.6))
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
    }
}

/* Text Styles */

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .bold))
            .lineSpacing(0)
    }
}

struct SmallTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .bold))
            .lineSpacing(5)
    }
}

struct SmallMonospaced: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .bold, design: .monospaced))
            .lineSpacing(5)
    }
}

struct LargeMonospaced: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .regular, design: .monospaced))
            .lineSpacing(5)
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
