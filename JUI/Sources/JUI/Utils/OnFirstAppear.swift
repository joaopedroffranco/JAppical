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
	/// A view modifier that triggers an action only the first time a view appears.
	///
	/// This modifier ensures that a given action is executed when the view first appears on the screen. It prevents the action
	/// from being called on subsequent appearances of the view.
	///
	/// The `FirstAppearModifier` is useful for performing one-time tasks, such as tracking analytics or triggering
	/// animations, when a view is initially shown.
	///
	/// ```
	/// SomeView()
	///     .onFirstAppear {
	///         print("First appearance")
	///     }
	/// ```
	func onFirstAppear(_ action: @escaping () -> Void) -> some View {
		modifier(FirstAppearModifier(action))
	}
}
