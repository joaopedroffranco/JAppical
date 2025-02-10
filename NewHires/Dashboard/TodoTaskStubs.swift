// Created in 2025

import Foundation
import JData
@testable import JAppical

enum TodoTaskStubs {
	static let instance = TodoTask(id: "1", text: "task 1", dueDate: 12345678, isDone: false, isRemoteUpdated: true)
	
	static let many = [
		"1": TodoTask(id: "1", text: "task 1", dueDate: 12345678, isDone: false, isRemoteUpdated: true),
		"2": TodoTask(id: "2", text: "task 1", dueDate: 12345678, isDone: false, isRemoteUpdated: true)
	]
	
	static let manyAndCompleted = [
		"1": TodoTask(id: "1", text: "task 1", dueDate: 12345678, isDone: true, isRemoteUpdated: true),
		"2": TodoTask(id: "2", text: "task 1", dueDate: 12345678, isDone: true, isRemoteUpdated: true)
	]
}

extension Dictionary where Value == TodoTask, Key == String {
	var asRowData: [String: TodoTaskRowViewModel] {
		mapValues { TodoTaskRowViewModel(from: $0)  }
	}
}
