//
//  Created by Joao Pedro Franco on 16/07/24.
//

import SwiftUI
import JFoundation

public struct CachedImage: View {
	var url: URL
	
	public init(url: URL) {
		self.url = url
	}
	
	public var body: some View {
		if let cachedImage = ImageCache[url] {
			cachedImage
				.resizable()
		} else {
			AsyncImage(url: url) { phase in
				cacheAndRender(phase, forUrl: url)
					.resizable()
			}
		}
	}
	
	private func cacheAndRender(_ phase: AsyncImagePhase, forUrl url: URL) -> Image {
		if case let .success(image) = phase {
			ImageCache[url] = image
			return image
		}
		
		return Image(DesignSystem.Assets.placeholder, bundle: .module)
	}
}

public class ImageCache {
	static private var cache: [URL: Image] = [:]
	static subscript(url: URL) -> Image? {
		get { cache[url] }
		set { cache[url] = newValue }
	}
	
	public static func clean() { cache = [:] }
}
