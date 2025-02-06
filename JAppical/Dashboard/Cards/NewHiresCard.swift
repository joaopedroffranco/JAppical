// Created in 2025

import SwiftUI
import JUI

struct NewHiresCard: View {
	var body: some View {
		VStack(alignment: .leading, spacing: DesignSystem.Spacings.small) {
			HStack(alignment: .center, spacing: DesignSystem.Spacings.small) {
				LocalImage(named: DesignSystem.Assets.personIcon)
					.frame(width: 15, height: 15, alignment: .center)

				Text(Strings.Dashboard.recentlyHires)
					.font(DesignSystem.Fonts.underSection)
					.foregroundColor(DesignSystem.Colors.darkGray)
			}
			.padding(.bottom, DesignSystem.Spacings.large)
			
			HStack(alignment: .center, spacing: DesignSystem.Spacings.large) {
				Text("4") // TODO: Get real number
					.font(DesignSystem.Fonts.huge)
					.foregroundColor(DesignSystem.Colors.primary)
				
				avatars([nil, nil])
			}
			
			Text(Strings.Dashboard.recentlyHiresStartDate)
				.font(DesignSystem.Fonts.default)
				.foregroundColor(DesignSystem.Colors.gray)

			Text(Strings.Dashboard.recentlyHiresAction)
				.font(DesignSystem.Fonts.description)
		}
	}
}

private extension NewHiresCard {
	@ViewBuilder
	func avatars(_ urls: [URL?]) -> some View {
		HStack(spacing: -10.0) {
			ForEach(urls, id: \.self) {
				Avatar(image: $0, borderColor: DesignSystem.Colors.white) // TODO: Overlay images
			}
		}
	}
}

struct NewHiresCard_Previews: PreviewProvider {
	static var previews: some View {
		NewHiresCard()
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
