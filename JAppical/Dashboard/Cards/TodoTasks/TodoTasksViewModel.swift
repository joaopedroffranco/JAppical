// Created in 2025

import Foundation
import Combine
import JData

class TodoTodoTasksViewModel: ObservableObject {
	private let taskService: TodoTaskServiceProtocol
	
	@Published var todoTodoTasks: [String: TodoTaskRowViewModel] = [:]
	@Published var isCompleted: Bool = false
	
	var todoTodoTasksCount: Int { todoTodoTasks.count }
	var sortedTodoTodoTasksArray: [TodoTaskRowViewModel] {
		todoTodoTasks.values.sorted { $0.dueTimeInterval < $1.dueTimeInterval }
	}
	
	init(
		taskService: TodoTaskServiceProtocol = TodoTaskService()
	) {
		self.taskService = taskService
	}
	
	func setup() {
		getTodoTodoTasks()
	}
	
	func didCheck(taskId: String) {
		todoTodoTasks[taskId]?.isDone.toggle()
		
		if allTodoTodoTasksChecked {
			isCompleted = true
		}
	}
}

private extension TodoTodoTasksViewModel {
	var allTodoTodoTasksChecked: Bool {
		todoTodoTasks.values.filter { !$0.isDone }.isEmpty
	}
	
	func getTodoTodoTasks() {
		taskService.get()
			.receive(on: DispatchQueue.main)
			.map { todoTodoTasks in
				guard let todoTodoTasks = todoTodoTasks else { return [:] }
				return todoTodoTasks.reduce(into: [:]) { result, task in
					result[task.id] = TodoTaskRowViewModel(from: task)
				}
			}
			.assign(to: &$todoTodoTasks)
	}
}
