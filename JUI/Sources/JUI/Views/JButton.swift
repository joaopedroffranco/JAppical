// Created in 2025

import SwiftUI

/// `JButton` is a customizable button component.
///
/// It allows setting the button text, background color, foreground color, and an optional action when tapped.
///
/// ```swift
/// JButton(
///     text: "Click me",
///     backgroundColor: .blue,
///     foregroundColor: .white
/// ) {
///     print("Button tapped!")
/// }
/// ```
///
/// If no action is provided, the button remains static.
/// ```swift
/// JButton(
///     text: "No action",
///     backgroundColor: .gray,
///     foregroundColor: .white
/// )
/// ```
public struct JButton: View {
	private let text: String
	private let backgroundColor: Color
	private let foregroundColor: Color
	private let action: () -> Void
	
	public init(
		text: String,
		backgroundColor: Color,
		foregroundColor: Color,
		action: @escaping (() -> Void) = {}
	) {
		self.text = text
		self.backgroundColor = backgroundColor
		self.foregroundColor = foregroundColor
		self.action = action
	}

	public var body: some View {
		Button(action: action) {
			Text(text)
				.font(DesignSystem.Fonts.button)
				.foregroundColor(foregroundColor)
				.padding(DesignSystem.Spacings.default)
				.frame(maxWidth: .infinity)
				.background(backgroundColor)
				.cornerRadius(DesignSystem.Radius.button)
		}
		.padding(.horizontal, DesignSystem.Spacings.default)
	}
}

struct JButton_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JButton(
				text: "One button",
				backgroundColor: DesignSystem.Colors.primary,
				foregroundColor: DesignSystem.Colors.white
			)
			JButton(
				text: "Another button",
				backgroundColor: DesignSystem.Colors.green,
				foregroundColor: DesignSystem.Colors.white
			)
		}
		.frame(width: 200, height: 42)
		.previewLayout(.sizeThatFits)
	}
}
