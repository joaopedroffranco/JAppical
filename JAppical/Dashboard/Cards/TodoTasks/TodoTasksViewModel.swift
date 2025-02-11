// Created in 2025

import Foundation
import Combine
import JData

/// A view model responsible for managing the state of the to-do tasks, including fetching the tasks,
/// marking tasks as completed or incomplete, and updating the view state accordingly.
///
/// The `TodoTasksViewModel` interacts with the `TodoTaskServiceProtocol` to retrieve to-do tasks and manage
/// their completion status. It also handles updating the view's state, which includes either showing the list of
/// tasks or indicating that all tasks are completed.
///
/// The class uses `@MainActor` to ensure UI updates are performed on the main thread.
///
/// ```
/// let todoTasksViewModel = TodoTasksViewModel(taskService: taskService)
/// todoTasksViewModel.setup() // Fetch all to-do tasks
/// todoTasksViewModel.didMark(taskId: "task123") // Mark a task as done or undone
/// ```
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
	
	func didMark(taskId: String) {
		guard var isDone = state.isDone(for: taskId) else { return }
		isDone.toggle()
		
		taskService.markAsDone(isDone, taskId: taskId)
		state.markAsDone(isDone, taskId: taskId)

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
