// Created in 2025

import Foundation
import Combine
import JData

@MainActor
class TodoTasksViewModel: ObservableObject {
	private let taskService: TodoTaskServiceProtocol
	
	@Published var state: TodoTasksViewState = .allCompleted
	
	init(taskService: TodoTaskServiceProtocol = TodoTaskService()) {
		self.taskService = taskService
	}
	
	func setup() {
		getTodoTasks()
	}
	
	func didCheck(taskId: String) {
		guard var isChecked = state.isChecked(for: taskId) else { return }
		isChecked.toggle()
		
		taskService.check(isChecked, taskId: taskId)
		state.check(isChecked, taskId: taskId)

		switch state {
		case let .todoTasks(tasks): if tasks.allCompleted { state = .allCompleted }
		default: break
		}
	}
}

private extension TodoTasksViewModel {
	func getTodoTasks() {
		Task {
			guard let todoTasks = await taskService.get() else { state = .allCompleted; return }
			let taskRows = todoTasks.reduce(into: [:]) { result, task in
				result[task.id] = TodoTaskRowViewModel(from: task)
			}
			
			if taskRows.allCompleted {
				state = .allCompleted
			} else {
				state = .todoTasks(taskRows)
			}
		}
	}
}
