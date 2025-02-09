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
	
	private var cancellables: Set<AnyCancellable> = []
	
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
			.receive(on: DispatchQueue.main)
			.sink { [weak self] updatedTask in
				guard let self = self else { return }
				if let _ = updatedTask { self.todoTasks[taskId]?.isDone.toggle() }
				
				if self.todoTasks.allCompleted { self.isCompleted = true }
			}
			.store(in: &cancellables)
	}
}

private extension TodoTasksViewModel {
	func getTodoTasks() {
		taskService.get()
			.receive(on: DispatchQueue.main)
			.map { todoTasks -> [String: TodoTaskRowViewModel] in
				guard let todoTasks = todoTasks else { return [:] }
				return todoTasks.reduce(into: [:]) { result, task in
					result[task.id] = TodoTaskRowViewModel(from: task)
				}
			}
			.sink { [weak self] taskRows in
				self?.todoTasks = taskRows
				self?.isCompleted = taskRows.allCompleted
			}
			.store(in: &cancellables)
	}
}
