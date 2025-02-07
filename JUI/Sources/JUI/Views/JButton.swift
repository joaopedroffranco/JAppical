// Created in 2025

import SwiftUI

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
