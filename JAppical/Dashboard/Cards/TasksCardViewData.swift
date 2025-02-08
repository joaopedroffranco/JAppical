// Created in 2025

import Foundation
import JData
import JUI
import SwiftUI

struct TaskCardViewData {
	let text: String
	let dueDate: String
	let color: Color
	var isDone: Bool

	init(
		text: String,
		dueDate: String,
		color: Color,
		isDone: Bool
	) {
		self.text = text
		self.dueDate = dueDate
		self.color = color
		self.isDone = isDone
	}
	
	init(from task: Task) {
		self.text = task.text
		self.isDone = task.isDone
		
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
