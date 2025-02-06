// Created in 2025

import SwiftUI
import JFoundation

public struct LocalImage: View {
	var named: String
	
	public init(named: String) {
		self.named = named
	}
	
	public var body: some View {
		Image(named, bundle: .module)
			.resizable()
	}
}
