// Created in 2025

import SwiftUI
import JUI

struct NewHiresCard: View {
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
				Text("4") // TODO: Get real number
					.font(DesignSystem.Fonts.huge)
					.foregroundColor(DesignSystem.Colors.primary)
				
				avatars([nil, nil])
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
	func avatars(_ urls: [URL?]) -> some View {
		HStack(spacing: -10.0) {
			ForEach(urls, id: \.self) {
				Avatar(image: $0, borderColor: DesignSystem.Colors.white)
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
