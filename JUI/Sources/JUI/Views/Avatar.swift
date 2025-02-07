// Created in 2025

import SwiftUI
import Kingfisher

public struct Avatar: View {
	private var image: URL?
	private var borderColor: Color?
	
	private var size = 32.0
	
	public init(image: URL? = nil, borderColor: Color? = nil) {
		self.image = image
		self.borderColor = borderColor
	}
	
	public var body: some View {
		Group {
			if let image = image {
				KFImage.url(image)
					.memoryCacheExpiration(.never)
					.diskCacheExpiration(.days(10))
			} else {
				LocalImage(named: DesignSystem.Assets.placeholderAvatar)
					.padding(6)
					.background(DesignSystem.Colors.lightGray)
			}
		}
		.frame(width: size, height: size)
		.clipShape(Circle())
		.overlay(
			Circle()
				.stroke(borderColor ?? .white, lineWidth: borderColor == nil ? .zero : 2)
		)
	}
}

struct Avatar_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Avatar()
			Avatar(borderColor: DesignSystem.Colors.dark)
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
