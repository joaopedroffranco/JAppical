// Created in 2025

import SwiftUI

/// `Checkbox` is a UI component that represents a selectable checkbox.
///
/// It visually updates based on its checked state and supports an animation when toggled.
/// The component also allows an action to be executed when tapped.
///
/// ```swift
/// Checkbox(true) {
///     print("Checkbox tapped!")
/// }
/// ```
///
/// If no initial state is provided, it defaults to unchecked.
/// ```swift
/// Checkbox()
/// ```
public struct Checkbox: View {
	private var isDone: Bool
	private var didTap: () -> Void
	
	private var size = 24.0
	
	@State private var opacity: Double = 0
	@State private var degree: Angle = Angle(degrees: 180)
	
	public init(_ isDone: Bool = false, didTap: @escaping () -> Void = {}) {
		self.isDone = isDone
		self.didTap = didTap
	}
	
	public var body: some View {
		Group {
			if isDone {
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
