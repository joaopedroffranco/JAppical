// Created in 2025

import Foundation
import Combine
import JData
import JUI
import SwiftUI

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
