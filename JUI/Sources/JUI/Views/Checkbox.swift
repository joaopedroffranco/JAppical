// Created in 2025

import SwiftUI

public struct Checkbox: View {
	private var isChecked: Bool
	private var didTap: () -> Void
	
	private var size = 24.0
	
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
					.background(DesignSystem.Colors.green.opacity(0.4))
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
