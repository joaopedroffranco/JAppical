// Created in 2025

import SwiftUI

/// A secure text field that can toggle between secure and plain text input.
///
/// This view provides a text field where the user can securely enter text (e.g., passwords). It includes a toggle
/// button that allows the user to switch between secure and plain text input. Additionally, it displays an optional
/// error message below the field if provided.
///
/// The `JSecureTextField` component allows for:
/// - Secure or plain text input toggle.
/// - A customizable placeholder.
/// - An optional error message display.
///
/// ```
/// JSecureTextField(text: $password, placeholder: "Enter your password", errorMessage: "Password is too weak")
/// ```
public struct JSecureTextField: View {
	@Binding private var text: String
	@State private var isSecure: Bool = true
	private let errorMessage: String?
	private let placeholder: String
	
	public init(
		text: Binding<String>,
		placeholder: String = "",
		isEnabled: Bool = true,
		errorMessage: String? = nil
	) {
		self._text = text
		self.placeholder = placeholder
		self.errorMessage = errorMessage
	}
	
	public var body: some View {
		VStack(alignment: .leading, spacing: DesignSystem.Spacings.small) {
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
			
			if let errorMessage = errorMessage {
				Text(errorMessage)
					.font(DesignSystem.Fonts.description)
					.foregroundColor(DesignSystem.Colors.error)
			}
		}
	}
}

struct JSecureTextField_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JSecureTextField(text: .constant(""))
			JSecureTextField(text: .constant(""), placeholder: "Type here...")
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
