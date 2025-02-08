// Created in 2025

import SwiftUI
import JUI

struct TasksCard: View {
	private var tasks: [TaskCardViewData]

	private var tasksCount: Int
	private var isCompleted: Bool {
		tasks.filter { !$0.isDone }.isEmpty
	}
	
	init(tasks: [TaskCardViewData]) {
		self.tasks = tasks
		self.tasksCount = tasks.count
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: .zero) {
			HStack(alignment: .center, spacing: DesignSystem.Spacings.default) {
				LocalImage(named: DesignSystem.Assets.todoIcon)
					.frame(width: 15, height: 15, alignment: .center)
				
				Text(Strings.Dashboard.todo)
					.font(DesignSystem.Fonts.underSection)
					.foregroundColor(DesignSystem.Colors.darkGray)
			}
			.padding(.bottom, 32)
			
			if isCompleted {
				emptyView
					.frame(maxWidth: .infinity)
			} else {
				ForEach(Array(tasks.enumerated()), id: \.offset) { offset, task in
					taskView(task, isFirst: offset == .zero, isLast: offset == tasksCount - 1)
				}
			}
		}
	}
}

private extension TasksCard {
	@ViewBuilder
	func taskView(_ task: TaskCardViewData, isFirst: Bool, isLast: Bool) -> some View {
		HStack(alignment: .top, spacing: DesignSystem.Spacings.default) {
			Checkbox() // TODO: get task state
			
			VStack(alignment: .leading, spacing: DesignSystem.Spacings.default) {
				Text(task.text)
					.font(DesignSystem.Fonts.description)
					.foregroundColor(DesignSystem.Colors.gray)
					.strikethrough(task.isDone)
				
				HStack(alignment: .center, spacing: DesignSystem.Spacings.small) {
					LocalImage(named: DesignSystem.Assets.calendarIcon, renderingMode: .template)
						.frame(width: 12, height: 12, alignment: .center)
						.foregroundColor(task.color)
					
					Text(task.dueDate)
						.font(DesignSystem.Fonts.description)
						.foregroundColor(task.color)
				}
			}
		}
		.padding(.top, isFirst ? .zero : 13)
		.padding(.bottom, isLast ? .zero : 13)
		
		if !isLast {
			Separator()
				.padding(.horizontal, -DesignSystem.Spacings.margin)
		}
	}
	
	@ViewBuilder
	var emptyView: some View {
		VStack(alignment: .center, spacing: DesignSystem.Spacings.default) {
			LocalImage(named: DesignSystem.Assets.successIcon)
				.frame(width: 40, height: 40, alignment: .center)

			Text(Strings.Dashboard.todoCompleted)
				.font(DesignSystem.Fonts.description)
				.multilineTextAlignment(.center)
		}
	}
}

struct TasksCard_Previews: PreviewProvider {
	static let tasks: [TaskCardViewData] = [
		.init(
			text: "Set up introductory meeting with your team",
			dueDate: "Today",
			color: .red,
			isDone: false
		),
		.init(
			text: "Collect your new hire’s access card",
			dueDate: "Tomorrow",
			color: .green,
			isDone: false
		),
		.init(
			text: "Set up 1:1 coffee dates with a minimum of 4 people from different departments",
			dueDate: "Today",
			color: .blue,
			isDone: true
		),
	]

	static var previews: some View {
		TasksCard(tasks: tasks)
		.padding(DesignSystem.Spacings.margin)
		.previewLayout(.sizeThatFits)
	}
}
