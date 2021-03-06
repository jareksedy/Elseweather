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

struct PlayButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var animate: Bool = false
    @Binding var inContinuousMode: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.customPrimary(for: colorScheme))
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .frame(maxWidth: .infinity)
            .background(inContinuousMode ?
                        LinearGradient(gradient: Gradient(colors: [.clear, .customPrimary(for: colorScheme)]), startPoint: colorScheme == .dark ? .top : .bottom, endPoint: colorScheme == .dark ? .bottom : .top)
                            .frame(width: 38, height: 38)
                            .clipShape(Circle())
                            .opacity(disabledButtonOpacity)
                        : nil
            )
            .background(
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(.customPrimary(for: colorScheme))
                            .opacity(inContinuousMode ? disabledButtonOpacity : 1.0)
                            .frame(width: 44, height: 44)
            )
            .overlay(inContinuousMode ?
                     Circle()
                        .trim(from: 0.0, to: animate ? 1.0 : 0.0)
                        .stroke(style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(animate ? 270.0 : 90.0))
                        .foregroundColor(.customPrimary(for: colorScheme))
                        .frame(width: 44, height: 44)
                        .animation(.easeOut(duration: continuousModeInterval).repeatForever(autoreverses: true))
                        .onAppear { self.animate = true }
                        .onDisappear { self.animate = false }
                     : nil
            )
    }
}

struct NextButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        Image(configuration.isPressed ? "button-next-pressed" : "button-next")
            .foregroundColor(.customPrimary(for: colorScheme))
            .frame(maxWidth: .infinity)
    }
}

struct MapsButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        Image(configuration.isPressed ? "button-maps-pressed" : "button-maps")
            .foregroundColor(.customPrimary(for: colorScheme))
            .frame(maxWidth: .infinity)
    }
}

struct LocationButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var cOpacity = 0.5
    @State private var cScale = 1.0
    @Binding var displayingLocalWeather: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.customPrimary(for: colorScheme))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .frame(maxWidth: .infinity)
            .overlay(displayingLocalWeather ?
                     Circle()
                        .stroke(lineWidth: 10.0)
                        .foregroundColor(.customPrimary(for: colorScheme))
                        .scaleEffect(cScale)
                        .opacity(cOpacity)
                        .frame(width: 24.0, height: 24.0)
                        .animation(.easeInOut(duration: 1.25))
                        .onAppear {
                            cScale = 2.75
                            cOpacity = 0.0
                        }
                        .onDisappear {
                            cScale = 1.0
                            cOpacity = 0.25
                        }
                     : nil
            )
    }
}

struct SettingsButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.customPrimary(for: colorScheme))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}

struct RetryButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.customPrimary(for: colorScheme))
            .padding(.leading, 75)
            .padding(.trailing, 75)
            .padding(.top, 15)
            .padding(.bottom, 15)
            .border(Color.customPrimary(for: colorScheme).opacity(disabledButtonOpacity), width: 2.0)
            .background(Color.customErrorBackground(for: colorScheme))
            .opacity(configuration.isPressed ? disabledButtonOpacity : 1.0)
    }
}

struct ToggleButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(1.0)
    }
}

struct BtStyleScaledBigger: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 24))
            .foregroundColor(Color.primary)
            .animation(.spring(response: 0.4, dampingFraction: 0.6))
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
    }
}

// MARK: - Switch toggle style.

struct CustomToggleStyle: ToggleStyle {
    var label = ""
    var onColor = Color.customDarkSecondary
    var offColor = Color.customDarkBackground
    var thumbColor = Color.customDarkPrimary
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Text(label)
                .kerning(-0.25)
                .textStyle(SmallTitle())
                .padding(.top, -2)
            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 26, style: .circular)
                    .strokeBorder(onColor, lineWidth: 2)
                    .background(RoundedRectangle(cornerSize: CGSize(width: 26.0, height: 26.0)).fill(configuration.isOn ? onColor : offColor))
                    .frame(width: 50, height: 30)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.35))
                    .overlay(
                        Circle()
                            .fill(configuration.isOn ? thumbColor : onColor)
                            .padding(configuration.isOn ? 5 : 10)
                            .offset(x: configuration.isOn ? 10 : -10)
                            .animation(.spring(response: 0.35, dampingFraction: 0.55)))
            }.buttonStyle(ToggleButton())
        }
    }
}

struct SettingsToggleStyle: ToggleStyle {
    var onColor = Color.customDarkSecondary
    var offColor = Color.customDarkBackground
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 26, style: .circular)
                    .strokeBorder(onColor, lineWidth: 2)
                    .frame(width: 42, height: 26)
                    .overlay(
                        Circle()
                            .fill(onColor)
                            .padding(configuration.isOn ? 6 : 8)
                            .offset(x: configuration.isOn ? 8 : -8)
                            .animation(.spring(response: 0.35, dampingFraction: 0.65)))
            }
        }
    }
}

// MARK: - Logo.

struct LogoImage: ViewModifier {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.customPrimary(for: colorScheme))
    }
}

// MARK: - Text styles.

struct LogoText: ViewModifier {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .semibold))
            .lineSpacing(5)
            .foregroundColor(Color.customPrimary(for: colorScheme))
    }
}

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
        .opacity.animation(.easeOut(duration: 2.0))
    }
    
    static var standardHeadingText: AnyTransition {
        .asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .move(edge: .top).combined(with: .opacity)).animation(.easeOut(duration: 0.15))
    }
}

// MARK: - Sheet view styles.

struct CustomBackgroundView: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = UIColor(Color.customBackground(for: colorScheme))
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct SheetCustomBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(CustomBackgroundView())
    }
}

extension View {
    func SheetCustomBackground() -> some View {
        self.modifier(SheetCustomBackgroundViewModifier())
    }
}
