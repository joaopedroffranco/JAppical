// Created in 2025

import SwiftUI
import Kingfisher

/// `Avatar` is a UI component for displaying user profile images.
///
/// It loads an image from a given URL and falls back to a placeholder if the image is unavailable.
/// Additionally, it allows an optional border color customization.
///
/// ```swift
/// Avatar(id: "123", image: URL(string: "https://example.com/avatar.png"), borderColor: .blue)
/// ```
///
/// If no image is provided, a default placeholder avatar will be displayed.
/// ```swift
/// Avatar(id: "123")
/// ```
public struct Avatar: View {
	private let id: String
	private var image: URL?
	private var borderColor: Color?
	
	private var size = 32.0
	
	public init(id: String, image: URL? = nil, borderColor: Color? = nil) {
		self.id = id
		self.image = image
		self.borderColor = borderColor
	}
	
	public var body: some View {
		Group {
			if let image = image {
				KFImage.url(image, cacheKey: id)
					.resizable()
					.placeholder { placeholder }
					.memoryCacheExpiration(.never)
					.diskCacheExpiration(.days(10))
					.scaledToFill()
			} else {
				placeholder
			}
		}
		.frame(width: size, height: size)
		.clipShape(Circle())
		.overlay(
			Circle()
				.stroke(borderColor ?? .white, lineWidth: borderColor == nil ? .zero : 2)
		)
	}
	
	@ViewBuilder
	private var placeholder: some View {
		LocalImage(named: DesignSystem.Assets.placeholderAvatar)
			.padding(6)
			.background(DesignSystem.Colors.lightGray)
	}
}

struct Avatar_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Avatar(id: "1")
			Avatar(id: "1", borderColor: DesignSystem.Colors.dark)
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
