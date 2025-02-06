// Created in 2025

import SwiftUI

public struct JCard<Content: View>: View {
	let content: Content
	
	public init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
	
	public var body: some View {
		content
			.padding(DesignSystem.Spacings.margin)
			.background(DesignSystem.Colors.background)
			.cornerRadius(DesignSystem.Radius.default)
			.overlay(
				RoundedRectangle(cornerRadius: DesignSystem.Radius.default)
					.stroke(DesignSystem.Colors.shadowBorder, lineWidth: 1)
			)
			.shadow(
				color: DesignSystem.Colors.shadow,
				radius: DesignSystem.Radius.default, x: 0, y: 4
			)
	}
}


struct JCard_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JCard {
				Text("Random Content Text")
			}
		}
		.padding(12)
		.previewLayout(.sizeThatFits)
	}
}
