// Created in 2025

import Foundation

public struct User {
	public let id: String
	public let name: String
	public let avatar: String?
	
	public init(
		id: String,
		name: String,
		avatar: String? = nil
	) {
		self.id = id
		self.name = name
		self.avatar = avatar
	}
}
