// Created in 2025

import SwiftUI
import JUI

struct NewHiresView: View {
	var body: some View {
		VStack(alignment: .leading, spacing: .zero) {
			Text(Strings.NewHires.title)
				.font(DesignSystem.Fonts.heading)
				.padding(.top, 32)
				.padding(.bottom, DesignSystem.Spacings.margin)
			
			JList(data: ["Joao", "Pedro", "Franco"]) { offset, hire in
				hireView(name: hire, isLast: offset == 2) // TODO: ViewModel
			}
			.cornerRadius(DesignSystem.Radius.small)
		}
		.padding(.horizontal, DesignSystem.Spacings.margin)
		.background(DesignSystem.Colors.lightGray)
	}
}

private extension NewHiresView {
	@ViewBuilder
	func hireView(name: String, isLast: Bool) -> some View {
		VStack(alignment: .leading, spacing: .zero) {
			HStack(spacing: DesignSystem.Spacings.margin) {
				Avatar(borderColor: DesignSystem.Colors.border)
				
				VStack(alignment: .leading, spacing: DesignSystem.Spacings.small) {
					Text(name)
						.font(DesignSystem.Fonts.default)
					
					Text(Strings.NewHires.firstDay("06 Fev 2025"))
						.font(DesignSystem.Fonts.description)
						.foregroundColor(DesignSystem.Colors.gray)
					
					Text(Strings.NewHires.sendMessage)
						.font(DesignSystem.Fonts.description)
						.foregroundColor(DesignSystem.Colors.primary)
				}
			}
			.padding(.horizontal, DesignSystem.Spacings.largeMargin)
			.padding(.vertical, DesignSystem.Spacings.margin)
			
			if !isLast {
				Separator()
			}
		}
	}
}

struct NewHiresView_Previews: PreviewProvider {
	static var previews: some View {
		NewHiresView()
	}
}
