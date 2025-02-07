// Created in 2025

import Foundation

public extension String {
	var asUrl: URL? {
		URL(string: self)
	}
}
