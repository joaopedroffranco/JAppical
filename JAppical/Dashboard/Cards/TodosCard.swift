// Created in 2025

import SwiftUI
import JUI

struct TodosCard: View {
	private var tasks: [String] = [] // TODO: ViewModel
	private var isCompleted: Bool = false // TODO: ViewModel

	private var tasksCount: Int
	
	init(tasks: [String]) {
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

private extension TodosCard {
	@ViewBuilder
	func taskView(_ string: String, isFirst: Bool, isLast: Bool) -> some View {
		HStack(alignment: .top, spacing: DesignSystem.Spacings.default) {
			Checkbox() // TODO: get task state
			
			VStack(alignment: .leading, spacing: DesignSystem.Spacings.default) {
				Text(string)
					.font(DesignSystem.Fonts.description)
					.foregroundColor(DesignSystem.Colors.gray)
				// .strikethrough()
				
				HStack(alignment: .center, spacing: DesignSystem.Spacings.small) {
					LocalImage(named: DesignSystem.Assets.calendarIcon)
						.frame(width: 12, height: 12, alignment: .center)
					
					Text("Today") // TODO: Get formated due time
						.font(DesignSystem.Fonts.description)
						.foregroundColor(DesignSystem.Colors.gray)
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

struct TodosCard_Previews: PreviewProvider {
	static var previews: some View {
		TodosCard(tasks: [
			"Set up introductory meeting with your team",
			"Collect your new hire’s access card",
			"Set up 1:1 coffee dates with a minimum of 4 people from different departments"
		])
		.padding(DesignSystem.Spacings.margin)
		.previewLayout(.sizeThatFits)
	}
}
