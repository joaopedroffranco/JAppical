// Created in 2025

import Foundation
import Combine
import JData

class DashboardViewModel: ObservableObject {
	private let taskService: TaskServiceProtocol
	private let newHireService: NewHireServiceProtocol
	
	@Published var tasks: [TaskCardViewData] = []
	@Published var thisMonthHires: [URL?] = []
	
	// private var cancellables: Set<AnyCancellable>
	
	init(
		taskService: TaskServiceProtocol = TaskService(),
		newHireService: NewHireServiceProtocol = NewHireService()
	) {
		self.taskService = taskService
		self.newHireService = newHireService
	}
	
	func setup() {
		getTasks()
		getThisMonthHires()
	}
}

private extension DashboardViewModel {
	func getTasks() {
		taskService.get()
			.receive(on: DispatchQueue.main)
			.map { tasks in
				guard let tasks = tasks else { return [] }
				return tasks.map { TaskCardViewData(from: $0) }
			}
			.assign(to: &$tasks)
	}
	
	func getThisMonthHires() {
		newHireService.getAll()
			.receive(on: DispatchQueue.main)
			.map { newHires in
				guard let newHires = newHires else { return [] }
				return newHires.filter { $0.startDate.asDate.isThisMonth }.map { $0.avatar?.asUrl }
			}
			.assign(to: &$thisMonthHires)
	}
}
