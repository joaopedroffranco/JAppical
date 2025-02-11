// Created in 2025

import Foundation
import Combine
import JData
import JUI
import SwiftUI

/// A view model that represents a single to-do task row in the UI, encapsulating the task's properties and its completion state.
///
/// The `TodoTaskRowViewModel` is responsible for providing the data required to display a single to-do task in the UI,
/// including the task's ID, text, due date, color, and completion status. It also handles updating the task's completion
/// state and notifying the UI about any changes.
///
/// **The `TodoTaskRowViewModel` class provides:**
/// - `id`: The unique identifier of the task.
/// - `text`: The description or text of the task.
/// - `dueDate`: A formatted string representing the due date of the task.
/// - `dueTimeInterval`: The due date represented as a `TimeInterval`.
/// - `color`: The color to be used for the task's display based on the due date (e.g., red for today, green for tomorrow).
/// - `isDone`: A published property that tracks whether the task is marked as completed or not.
/// - `init(from:)`: An initializer that creates a view model from a `TodoTask` object, extracting and formatting the task's properties.
/// - A computed property `allCompleted` for a dictionary of `TodoTaskRowViewModel` objects to check if all tasks in the dictionary are marked as completed.
///
/// The class uses `@Published` to allow automatic updates to the view when the task's `isDone` state changes.
///
/// ```
/// let taskViewModel = TodoTaskRowViewModel(from: task) // Initialize from a TodoTask
/// taskViewModel.isDone.toggle() // Mark the task as done or undone
/// ```
class TodoTaskRowViewModel: ObservableObject, Identifiable {
	let id: String
	let text: String
	let dueDate: String
	let dueTimeInterval: TimeInterval
	let color: Color
	@Published var isDone: Bool
	
	private var cancellables: Set<AnyCancellable> = []

	init(
		id: String,
		text: String,
		dueDate: String,
		dueTimeInterval: TimeInterval,
		color: Color,
		isDone: Bool
	) {
		self.id = id
		self.text = text
		self.dueDate = dueDate
		self.dueTimeInterval = dueTimeInterval
		self.color = color
		self.isDone = isDone
	}
	
	init(from task: TodoTask) {
		self.id = task.id
		self.text = task.text
		self.isDone = task.isDone
		self.dueTimeInterval = task.dueDate

		let dueDate = task.dueDate.asDate
		if dueDate.isToday {
			self.dueDate = Strings.today
			self.color = DesignSystem.Colors.red
		} else if dueDate.isTomorrow {
			self.dueDate = Strings.tomorrow
			self.color = DesignSystem.Colors.green
		} else {
			self.dueDate = Strings.dueDate(dueDate.asString)
			self.color = DesignSystem.Colors.gray
		}
	}
}

extension TodoTaskRowViewModel: Equatable {
	static func == (lhs: TodoTaskRowViewModel, rhs: TodoTaskRowViewModel) -> Bool {
		lhs.id == rhs.id && lhs.isDone == rhs.isDone
	}
}

extension Dictionary where Value == TodoTaskRowViewModel {
	var allCompleted: Bool {
		values.first { !$0.isDone } == nil
	}
}
