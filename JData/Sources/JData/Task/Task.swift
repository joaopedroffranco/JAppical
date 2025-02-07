// Created in 2025

import Foundation

public struct Task {
	public let text: String
	public let dueDate: TimeInterval
	public let isDone: Bool
	
	public init(
		text: String,
		dueDate: TimeInterval,
		isDone: Bool
	) {
		self.text = text
		self.dueDate = dueDate
		self.isDone = isDone
	}
}
