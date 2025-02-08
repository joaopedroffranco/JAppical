// Created in 2025

import Foundation

public struct TodoTask {
	public let id: String
	public let text: String
	public let dueDate: TimeInterval
	public let isDone: Bool
	
	public init(
		id: String,
		text: String,
		dueDate: TimeInterval,
		isDone: Bool
	) {
		self.id = id
		self.text = text
		self.dueDate = dueDate
		self.isDone = isDone
	}
}

extension TodoTask: Codable {}
