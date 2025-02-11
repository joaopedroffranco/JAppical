// Created in 2025

import SwiftUI

/// A simple horizontal separator line.
///
/// This view renders a thin horizontal line (1pt in height) that can be used to visually separate content. The separator
/// has a customizable color defined by the `DesignSystem.Colors.separator`.
public struct Separator: View {
	public init() {}
	
	public var body: some View {
		Rectangle()
			.frame(height: 1)
			.foregroundColor(DesignSystem.Colors.separator)
	}
}

struct Separator_Previews: PreviewProvider {
	static var previews: some View {
		Separator()
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
