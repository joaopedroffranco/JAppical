// Created in 2025

import Foundation

public struct NewHire {
	public let id: String
	public let name: String
	public let startDate: TimeInterval
	public let avatar: String?
	
	public init(
		id: String,
		name: String,
		startDate: TimeInterval,
		avatar: String?
	) {
		self.id = id
		self.name = name
		self.startDate = startDate
		self.avatar = avatar
	}
}

extension NewHire: Decodable {}
