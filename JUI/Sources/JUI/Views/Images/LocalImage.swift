// Created in 2025

import SwiftUI
import JFoundation

/// A view that displays an image from the app's asset catalog.
///
/// This view renders an image from the asset catalog with the option to adjust its rendering mode. The image can be
/// rendered with either its original colors or as a template (where the colors can be adjusted based on the context).
///
/// The `LocalImage` component provides:
/// - The ability to specify the image name from the asset catalog.
/// - An option to set the rendering mode of the image (`.original` or `.template`).
///
/// ```
/// LocalImage(named: "iconName", renderingMode: .template)
/// ```
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
