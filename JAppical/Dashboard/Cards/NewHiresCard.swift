// Created in 2025

import SwiftUI
import JUI

struct NewHiresCard: View {
	private var avatars: [URL?]
	
	private var avatarsCount: Int { avatars.count }
	private let maxNumberOfAvatars = 5

	init(avatars: [URL?]) {
		self.avatars = avatars
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
				Text(avatarsCount.description)
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
			ForEach(avatars.prefix(maxNumberOfAvatars), id: \.self) {
				Avatar(image: $0, borderColor: DesignSystem.Colors.white)
			}
		}
	}
}

struct NewHiresCard_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			NewHiresCard(avatars: [nil, nil, nil])
			NewHiresCard(avatars: [nil, nil, nil, nil, nil, nil, nil])
		}
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
