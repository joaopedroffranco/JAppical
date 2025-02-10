// Created in 2025

import SwiftUI

public struct Checkbox: View {
	private var isChecked: Bool
	private var didTap: () -> Void
	
	private var size = 24.0
	
	@State private var opacity: Double = 0
	@State private var degree: Angle = Angle(degrees: 180)
	
	public init(_ isChecked: Bool = false, didTap: @escaping () -> Void = {}) {
		self.isChecked = isChecked
		self.didTap = didTap
	}
	
	public var body: some View {
		Group {
			if isChecked {
				LocalImage(named: DesignSystem.Assets.checkedIcon)
					.padding(.horizontal, 4)
					.padding(.vertical, 7)
					.opacity(opacity)
					.rotationEffect(degree)
					.background(DesignSystem.Colors.green.opacity(0.4))
					.onAppear {
						withAnimation(.easeIn(duration: 0.2)) {
							opacity = 1
							degree = Angle(degrees: 0)
						}
					}
			} else {
				Circle()
					.stroke(DesignSystem.Colors.gray.opacity(0.7), lineWidth: 3)
			}
		}
		.frame(width: size, height: size)
		.clipShape(Circle())
		.onTapGesture { didTap() }
	}
}

struct Checkbox_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Checkbox()
			Checkbox(true)
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
