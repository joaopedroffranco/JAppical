// Created in 2025

import SwiftUI

public struct JTextField: View {
	@State private var text: String = ""
	@State private var isSecure: Bool = false
	private let isPassword: Bool
	private let placeholder: String
	
	public init(
		placeholder: String = "",
		isPassword: Bool = false
	) {
		self.isPassword = isPassword
		self.placeholder = placeholder
	}
	
	public var body: some View {
		Group {
			if isPassword && isSecure {
				SecureField(placeholder, text: $text)
			} else {
				TextField(placeholder, text: $text)
			}
		}
		.padding(.horizontal, DesignSystem.Spacings.margin)
		.padding(.vertical, 12)
		.background(DesignSystem.Colors.textfield)
		.cornerRadius(DesignSystem.Radius.textfield)
		.overlay(
			RoundedRectangle(cornerRadius: DesignSystem.Radius.textfield)
				.stroke(DesignSystem.Colors.textfieldBorder, lineWidth: 1)
		)
		.overlay(
			HStack {
				Spacer()
				Button(action: { isSecure.toggle() }) {
					LocalImage(named: isSecure ? DesignSystem.Assets.eyeIcon : DesignSystem.Assets.eyeCutIcon)
						.scaledToFit()
						.frame(width: 24, height: 20)
				}
			}
				.padding(.trailing, 12)
				.opacity(isPassword ? 1 : 0)
		)
	}
}

struct JTextField_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JTextField()
			JTextField(placeholder: "Type here...")
			JTextField(isPassword: true)
			JTextField(placeholder: "Password here...", isPassword: true)
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
