// Created in 2025

import SwiftUI
import JFoundation

public struct LocalImage: View {
	var named: String
	var renderingMode: Image.TemplateRenderingMode
	
	public init(named: String, renderingMode: Image.TemplateRenderingMode = .original) {
		self.named = named
		self.renderingMode = renderingMode
	}
	
	public var body: some View {
		Image(named, bundle: .module)
			.resizable()
			.renderingMode(renderingMode)
	}
}
