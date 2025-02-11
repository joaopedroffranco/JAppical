// Created in 2025

import Foundation

enum TodoTasksViewState: Equatable {
	case allCompleted
	case todoTasks([String: TodoTaskRowViewModel])
	
	var count: Int {
		switch self {
		case .allCompleted: return .zero
		case let .todoTasks(tasks): return tasks.count
		}
	}
	
	var sortedTasksArray: [TodoTaskRowViewModel] {
		switch self {
		case .allCompleted: return []
		case let .todoTasks(tasks): return tasks.values.sorted { $0.dueTimeInterval < $1.dueTimeInterval }
		}
	}
	
	func isDone(for taskId: String) -> Bool? {
		switch self {
		case .allCompleted: return nil
		case let .todoTasks(tasks): return tasks[taskId]?.isDone ?? nil
		}
	}
	
	func markAsDone(_ isDone: Bool, taskId: String) {
		switch self {
		case .allCompleted: break
		case let .todoTasks(tasks):
			tasks[taskId]?.isDone = isDone
		}
	}
}
