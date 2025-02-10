// Created in 2025

import Foundation
import SwiftUI

public struct FirstAppearModifier: ViewModifier {
	
	private let action: () -> Void
	@State private var hasAppeared = false
	
	public init(_ action: @escaping () -> Void) {
		self.action = action
	}
	
	public func body(content: Content) -> some View {
		content
			.onAppear {
				guard !hasAppeared else { return }
				hasAppeared = true
				action()
			}
	}
}

public extension View {
	func onFirstAppear(_ action: @escaping () -> Void) -> some View {
		modifier(FirstAppearModifier(action))
	}
}
