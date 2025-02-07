// Created in 2025

import SwiftUI

public struct JTextField: View {
	@State private var text: String = ""
	private let placeholder: String
	
	public init(placeholder: String = "") {
		self.placeholder = placeholder
	}
	
	public var body: some View {
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
	}
}

struct JTextField_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JTextField()
			JTextField(placeholder: "Type here...")
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
