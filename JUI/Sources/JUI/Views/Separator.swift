// Created in 2025

import SwiftUI

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
