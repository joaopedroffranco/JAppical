// Created in 2025

import SwiftUI
import JUI

struct DashboardView: View {
	private var sectionsMargin = DesignSystem.Spacings.large
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: sectionsMargin) {
				Group {
					logoHeader
					header
					Separator()
					todo
					Separator()
					newHires
				}
				.padding(.horizontal, DesignSystem.Spacings.margin)
				
				Spacer()
			}
			.padding(.top, sectionsMargin)
		}
	}
}

// MARK: - Cards
private extension DashboardView {
	@ViewBuilder
	var logoHeader: some View {
		VStack(alignment: .center, spacing: DesignSystem.Spacings.small) {
			LocalImage(named: DesignSystem.Assets.logo)
				.scaledToFill()
				.frame(width: 135, height: 49)
			
			Text("Welcome back, Joao") // TODO: Get name
				.font(DesignSystem.Fonts.title)
		}
	}
	
	@ViewBuilder
	var header: some View {
		JCard {
			VStack(alignment: .leading, spacing: DesignSystem.Spacings.small) {
				LocalImage(named: DesignSystem.Assets.header)
					.scaledToFill()
					.cornerRadius(DesignSystem.Radius.default)
					.padding(.top, DesignSystem.Spacings.huge)
				
				Text(Strings.Dashboard.newHireJourneyTitle)
					.font(DesignSystem.Fonts.heading)
				
				Text(Strings.Dashboard.newHireJourneyDescription)
					.font(DesignSystem.Fonts.description)
			}
		}
	}
	
	@ViewBuilder
	var todo: some View {
		section(title: Strings.Dashboard.Sections.todos) {
			JCard {
				VStack {
					// TODO: Todo View here
					Text(Strings.Dashboard.newHireJourneyTitle)
						.font(DesignSystem.Fonts.heading)
					
					Text(Strings.Dashboard.newHireJourneyDescription)
						.font(DesignSystem.Fonts.heading)
				}
			}
		}
	}
	
	@ViewBuilder
	var newHires: some View {
		section(title: Strings.Dashboard.Sections.newHires) {
			JCard {
				HStack {
					NewHiresCard()
					Spacer()
				}
			}
		}
	}
}

// MARK: - Generic components
private extension DashboardView {
	@ViewBuilder
	func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
		VStack(alignment: .leading, spacing: .zero) {
			Text(title)
				.font(DesignSystem.Fonts.section)
				.padding(.bottom, sectionsMargin)
			
			content()
		}
	}
}

// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
	static var previews: some View {
		DashboardView()
	}
}
