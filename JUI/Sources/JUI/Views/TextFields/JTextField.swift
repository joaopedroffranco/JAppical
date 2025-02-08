// Created in 2025

import SwiftUI

public struct JTextField: View {
	@Binding private var text: String
	private let placeholder: String
	private let isEnabled: Bool
	private let errorMessage: String?
	
	public init(
		text: Binding<String>,
		placeholder: String = "",
		isEnabled: Bool = true,
		errorMessage: String? = nil
	) {
		self._text = text
		self.placeholder = placeholder
		self.isEnabled = isEnabled
		self.errorMessage = errorMessage
	}
	
	public var body: some View {
		VStack(alignment: .leading, spacing: DesignSystem.Spacings.small) {
			TextField(placeholder, text: $text)
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
				.disabled(!isEnabled)
			
			if let errorMessage = errorMessage {
				Text(errorMessage)
					.font(DesignSystem.Fonts.description)
					.foregroundColor(DesignSystem.Colors.error)
			}
		}
	}
}

struct JTextField_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JTextField(text: .constant(""))
			JTextField(text: .constant(""), placeholder: "Type here...")
			JTextField(text: .constant(""), errorMessage: "This is an error")
			JTextField(text: .constant(""), isEnabled: false)
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
