// Created in 2025

import Foundation

public extension String {
	var asUrl: URL? {
		URL(string: self)
	}
	
	var isValidEmail: Bool {
		let emailPattern = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z]{2,7}$"
		return range(of: emailPattern, options: .regularExpression) != nil
	}
}
