// Created in 2025

import SwiftUI
import JUI

struct TasksCard: View {
	@StateObject private var viewModel = TasksViewModel()
	
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
			
			if viewModel.isCompleted {
				emptyView
					.frame(maxWidth: .infinity)
			} else {
				ForEach(Array(viewModel.sortedTasksArray.enumerated()), id: \.offset) { offset, task in
					TaskRow(viewModel: task, isFirst: offset == .zero, isLast: offset == viewModel.tasksCount - 1) {
						viewModel.didCheck(taskId: task.id)
					}
				}
			}
		}
		.onAppear { viewModel.setup() }
	}
}

private extension TasksCard {
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

//struct TasksCard_Previews: PreviewProvider {
//	static let tasks: [String: TaskCardViewData] = [
//		"1": .init(
//			text: "Set up introductory meeting with your team",
//			dueDate: "Today",
//			color: .red,
//			isDone: false
//		),
//		"2": .init(
//			text: "Collect your new hire’s access card",
//			dueDate: "Tomorrow",
//			color: .green,
//			isDone: false
//		),
//		"3": .init(
//			text: "Set up 1:1 coffee dates with a minimum of 4 people from different departments",
//			dueDate: "Today",
//			color: .blue,
//			isDone: true
//		),
//	]
//
//	static let viewModel: TasksViewModel = {
//		let viewModel = TasksViewModel()
//		viewModel.tasks = tasks
//	}()
//
//	static var previews: some View {
//		TasksCard(viewModel: viewModel)
//			.padding(DesignSystem.Spacings.margin)
//			.previewLayout(.sizeThatFits)
//	}
//}
