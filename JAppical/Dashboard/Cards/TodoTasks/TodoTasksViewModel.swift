// Created in 2025

import Foundation
import Combine
import JData

@MainActor
class TodoTasksViewModel: ObservableObject {
	private let taskService: TodoTaskServiceProtocol
	
	@Published var todoTasks: [String: TodoTaskRowViewModel] = [:]
	@Published var isCompleted: Bool = false
	
	var todoTasksCount: Int { todoTasks.count }
	var sortedTodoTasksArray: [TodoTaskRowViewModel] {
		todoTasks.values.sorted { $0.dueTimeInterval < $1.dueTimeInterval }
	}
	
	init(
		taskService: TodoTaskServiceProtocol = TodoTaskService()
	) {
		self.taskService = taskService
	}
	
	func setup() {
		getTodoTasks()
	}
	
	func didCheck(taskId: String) {
		guard var isTaskChecked = todoTasks[taskId]?.isDone else { return }
		isTaskChecked.toggle()
		
		taskService.check(taskId: taskId, isChecked: isTaskChecked)
		todoTasks[taskId]?.isDone.toggle()
		if todoTasks.allCompleted { self.isCompleted = true }
	}
}

private extension TodoTasksViewModel {
	func getTodoTasks() {
		Task {
			guard let todoTasks = await taskService.get() else { todoTasks = [:]; return }
			let taskRows = todoTasks.reduce(into: [:]) { result, task in
				result[task.id] = TodoTaskRowViewModel(from: task)
			}
			self.todoTasks = taskRows
			isCompleted = taskRows.allCompleted
		}
	}
}
