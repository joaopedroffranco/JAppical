// Created in 2025

import SwiftUI
import JUI

struct NewHiresCard: View {
	private var newHires: [NewHireViewData]
	
	private var count: Int { newHires.count }
	private let maxNumberOfAvatars = 5

	init(newHires: [NewHireViewData]) {
		self.newHires = newHires
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: .zero) {
			HStack(alignment: .center, spacing: DesignSystem.Spacings.default) {
				LocalImage(named: DesignSystem.Assets.personIcon)
					.frame(width: 15, height: 15, alignment: .center)

				Text(Strings.Dashboard.recentlyHires)
					.font(DesignSystem.Fonts.underSection)
					.foregroundColor(DesignSystem.Colors.darkGray)
			}
			.padding(.bottom, 32)

			HStack(alignment: .center, spacing: 22) {
				Text(count.description)
					.font(DesignSystem.Fonts.huge)
					.foregroundColor(DesignSystem.Colors.primary)
				
				avatarsView
			}
			.padding(.bottom, DesignSystem.Spacings.default)
			
			Text(Strings.Dashboard.recentlyHiresStartDate)
				.font(DesignSystem.Fonts.description)
				.foregroundColor(DesignSystem.Colors.gray)
				.padding(.bottom, DesignSystem.Spacings.default)

			Text(Strings.Dashboard.recentlyHiresAction)
				.font(DesignSystem.Fonts.default)
		}
	}
}

private extension NewHiresCard {
	@ViewBuilder
	var avatarsView: some View {
		HStack(spacing: -10.0) {
			ForEach(newHires.prefix(maxNumberOfAvatars), id: \.self) {
				Avatar(id: $0.id, image: $0.avatar, borderColor: DesignSystem.Colors.white)
			}
		}
	}
}

struct NewHiresCard_Previews: PreviewProvider {
	static let newHire = NewHireViewData(name: "Name", startDate: "Due 15 Feb 2025", startTimeInterval: 1111111)
	
	static var previews: some View {
		Group {
			NewHiresCard(newHires: [newHire, newHire, newHire])
			NewHiresCard(newHires: [newHire, newHire, newHire, newHire, newHire, newHire, newHire])
		}
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
