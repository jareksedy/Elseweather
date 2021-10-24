//
//  ViewStyles.swift
//  Elseweather
//
//  Created by Jarek Šedý on 28.09.2021.
//

import SwiftUI

struct Divider: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var width: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color.customPrimary(for: colorScheme))
            .opacity(dividerOpacity)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
    init(_ width: CGFloat) {
        self.width = width
    }
}

// MARK: - Button styles.

struct defaultControlButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.customPrimary(for: colorScheme))
            //.opacity(dividerOpacity)
            .animation(.spring(response: 0.4, dampingFraction: 0.6))
            .scaleEffect(configuration.isPressed ? 0.75 : 1.0)
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

// MARK: - Logo.

struct LogoImage: ViewModifier {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.customPrimary(for: colorScheme))
            .padding(.trailing, -5)
            .padding(.top, 1)
    }
}

// MARK: - Text styles.

struct LargeTitle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    func body(content: Content) -> some View {
        content
            .font(.system(size: 36, weight: .light))
            .lineSpacing(0)
            .foregroundColor(Color.customPrimary(for: colorScheme))
    }
}

struct SmallTitle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .regular))
            .lineSpacing(5)
            .foregroundColor(Color.customPrimary(for: colorScheme))
    }
}

struct SmallMonospaced: ViewModifier {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .semibold, design: .monospaced))
            .lineSpacing(5)
            .foregroundColor(Color.customPrimary(for: colorScheme))
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

// MARK: - Animations.

extension Animation {
    static var standard: Animation {
        .easeOut(duration: 0.12)
    }
}

// MARK: - Transitions.

extension AnyTransition {
    static var standard: AnyTransition {
        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    }
    
    static var standardBackground: AnyTransition {
        .opacity.animation(.easeOut(duration: 1.0))
    }
    
    static var standardHeadingText: AnyTransition {
        .asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .move(edge: .top).combined(with: .opacity)).animation(.easeOut(duration: 0.15))
    }
}
