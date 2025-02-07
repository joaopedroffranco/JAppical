// Created in 2025

import SwiftUI

struct Loading: View {
	var body: some View {
		LocalImage(named: DesignSystem.Assets.loading)
			.scaledToFit()
			.frame(width: 48, height: 48)
			.rotationEffect(Angle(degrees: 360))
			.animation(
				Animation.linear(duration: 1)
					.repeatForever(autoreverses: false), value: true
			)
	}
}

struct Loading_Previews: PreviewProvider {
	static var previews: some View {
		Loading()
			.previewLayout(.sizeThatFits)
	}
}
