// Created in 2025

import SwiftUI
import JUI

struct TodoTasksCard: View {
	@StateObject var viewModel = TodoTasksViewModel()
	
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
			
			switch viewModel.state {
			case .allCompleted:
				emptyView
					.frame(maxWidth: .infinity)
			case .todoTasks:
				ForEach(Array(viewModel.state.sortedTasksArray.enumerated()), id: \.offset) { offset, task in
					TodoTaskRow(viewModel: task, isFirst: offset == .zero, isLast: offset == viewModel.state.count - 1) {
						viewModel.didCheck(taskId: task.id)
					}
				}
			}
		}
		.onFirstAppear { viewModel.setup() }
	}
}

private extension TodoTasksCard {
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

struct TodoTasksCard_Previews: PreviewProvider {
	static let todoTasks: [String: TodoTaskRowViewModel] = [
		"1": .init(
			id: "1",
			text: "Set up introductory meeting with your team",
			dueDate: "Today",
			dueTimeInterval: 1111111,
			color: .red,
			isDone: false
		),
		"2": .init(
			id: "2",
			text: "Collect your new hire’s access card",
			dueDate: "Tomorrow",
			dueTimeInterval: 1111111,
			color: .green,
			isDone: false
		),
		"3": .init(
			id: "3",
			text: "Set up 1:1 coffee dates with a minimum of 4 people from different departments",
			dueDate: "Today",
			dueTimeInterval: 1111111,
			color: .blue,
			isDone: true
		),
	]
	
	static let dataViewModel: TodoTasksViewModel = {
		let viewModel = TodoTasksViewModel()
		viewModel.state = .todoTasks(todoTasks)
		return viewModel
	}()
	
	static var previews: some View {
		Group {
			TodoTasksCard(viewModel: dataViewModel)
			TodoTasksCard()
		}
		.padding(DesignSystem.Spacings.margin)
		.previewLayout(.sizeThatFits)
	}
}
