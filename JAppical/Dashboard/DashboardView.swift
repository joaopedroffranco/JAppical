// Created in 2025

import SwiftUI
import JUI

struct DashboardView: View {
	@ObservedObject var viewModel: DashboardViewModel
	
	private let sectionsMargin = DesignSystem.Spacings.margin
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			LazyVStack(spacing: sectionsMargin) {
				Group {
					logoHeader
					header
					Separator()
					tasks
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
			LocalImage(named: DesignSystem.Assets.logoExtended)
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
	var tasks: some View {
		section(title: Strings.Dashboard.Sections.todos) {
			JCard {
				TasksCard(tasks: viewModel.tasks)
			}
		}
	}
	
	@ViewBuilder
	var newHires: some View {
		section(title: Strings.Dashboard.Sections.newHires) {
			NavigationLink { NewHiresScreen() } label: {
				JCard {
					HStack {
						NewHiresCard(avatars: viewModel.thisMonthHires)
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
//struct DashboardView_Previews: PreviewProvider {
//	static var previews: some View {
//		DashboardView()
//	}
//}
