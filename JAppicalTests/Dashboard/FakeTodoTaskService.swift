// Created in 2025

import Foundation
import JData

class FakeTodoTaskService: TodoTaskServiceProtocol {
	var tasks: [String: TodoTask]?
	
	func get() async -> [TodoTask]? {
		guard let values = tasks?.values else { return nil }
		return Array(values)
	}

	func markAsDone(_ isDone: Bool, taskId: String) {
		tasks?[taskId]?.isDone = isDone
	}
}
