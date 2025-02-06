// Created in 2025

import SwiftUI
import JUI

struct DashboardView: View {
	private let sectionsMargin = DesignSystem.Spacings.margin
	
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
			}
			.padding(.top, sectionsMargin)
		}
	}
}

// MARK: - Cards
private extension DashboardView {
	@ViewBuilder
	var logoHeader: some View {
		VStack(alignment: .center, spacing: DesignSystem.Spacings.default) {
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
					.padding(.top, 49)
					.padding(.bottom, DesignSystem.Spacings.default)
				
				Text(Strings.Dashboard.newHireJourneyTitle)
					.font(DesignSystem.Fonts.heading)
				
				Text(Strings.Dashboard.newHireJourneyDescription)
					.font(DesignSystem.Fonts.default)
			}
		}
	}
	
	@ViewBuilder
	var todo: some View {
		section(title: Strings.Dashboard.Sections.todos) {
			JCard {
				TodosCard(tasks: [
					"Set up introductory meeting with your team",
					"Collect your new hire’s access card",
					"Set up 1:1 coffee dates with a minimum of 4 people from different departments"
				])
			}
		}
	}
	
	@ViewBuilder
	var newHires: some View {
		section(title: Strings.Dashboard.Sections.newHires) {
			NavigationLink(destination: NewHiresScreen()) {
				JCard {
					HStack {
						NewHiresCard()
						Spacer()
					}
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
				.frame(maxWidth: .infinity)
		}
		.buttonStyle(PlainButtonStyle())
	}
}

// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
	static var previews: some View {
		DashboardView()
	}
}
