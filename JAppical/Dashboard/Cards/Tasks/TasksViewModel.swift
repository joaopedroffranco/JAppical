// Created in 2025

import Foundation
import Combine
import JData

class TasksViewModel: ObservableObject {
	private let taskService: TaskServiceProtocol
	
	@Published var tasks: [String: TaskRowViewModel] = [:]
	@Published var isCompleted: Bool = false
	
	var tasksCount: Int { tasks.count }
	var sortedTasksArray: [TaskRowViewModel] {
		tasks.values.sorted { $0.dueTimeInterval < $1.dueTimeInterval }
	}
	
	init(
		taskService: TaskServiceProtocol = TaskService()
	) {
		self.taskService = taskService
	}
	
	func setup() {
		getTasks()
	}
	
	func didCheck(taskId: String) {
		tasks[taskId]?.isDone.toggle()
		
		if allTasksChecked {
			isCompleted = true
		}
	}
}

private extension TasksViewModel {
	var allTasksChecked: Bool {
		tasks.values.filter { !$0.isDone }.isEmpty
	}
	
	func getTasks() {
		taskService.get()
			.receive(on: DispatchQueue.main)
			.map { tasks in
				guard let tasks = tasks else { return [:] }
				return tasks.reduce(into: [:]) { result, task in
					result[task.id] = TaskRowViewModel(from: task)
				}
			}
			.assign(to: &$tasks)
	}
}
