// Created in 2025

import SwiftUI

public struct JSecureTextField: View {
	@State private var text: String = ""
	@State private var isSecure: Bool = false
	private let placeholder: String
	
	public init(placeholder: String = "") {
		self.placeholder = placeholder
	}
	
	public var body: some View {
		Group {
			if isSecure {
				SecureField(placeholder, text: $text)
			} else {
				TextField(placeholder, text: $text)
			}
		}
		.frame(height: 18)
		.font(DesignSystem.Fonts.textfield)
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
		)
	}
}

struct JSecureTextField_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JSecureTextField()
			JSecureTextField(placeholder: "Type here...")
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
