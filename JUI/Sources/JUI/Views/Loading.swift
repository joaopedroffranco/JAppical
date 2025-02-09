// Created in 2025

import SwiftUI

public struct Loading: View {
	@State private var degreesRotating = 0.0
	@State private var isAnimating = false

	public init() {}
	
	public var body: some View {
		LocalImage(named: DesignSystem.Assets.loading)
			.scaledToFit()
			.frame(width: 48, height: 48)
			.rotationEffect(Angle(degrees: degreesRotating))
			.onAppear {
				isAnimating = true
				withAnimation(.linear(duration: 1)
					.speed(1.5).repeatForever(autoreverses: false)) {
						degreesRotating = 360.0
					}
			}
			.onDisappear { isAnimating = false }
	}
}

struct Loading_Previews: PreviewProvider {
	static var previews: some View {
		Loading()
			.previewLayout(.sizeThatFits)
	}
}
