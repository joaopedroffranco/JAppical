// Created in 2025

import SwiftUI
import JUI

struct TaskRow: View {
	@ObservedObject private var viewModel: TaskRowViewModel
	private var didCheck: () -> Void
	private var isFirst: Bool
	private var isLast: Bool
	
	init(viewModel: TaskRowViewModel, isFirst: Bool, isLast: Bool, didCheck: @escaping () -> Void = {}) {
		self.viewModel = viewModel
		self.didCheck = didCheck
		self.isFirst = isFirst
		self.isLast = isLast
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: .zero) {
			HStack(alignment: .top, spacing: DesignSystem.Spacings.default) {
				Checkbox(viewModel.isDone, didTap: didCheck)
				
				VStack(alignment: .leading, spacing: DesignSystem.Spacings.default) {
					Text(viewModel.text)
						.font(DesignSystem.Fonts.description)
						.foregroundColor(viewModel.isDone ? DesignSystem.Colors.gray : DesignSystem.Colors.dark)
						.strikethrough(viewModel.isDone)
					
					HStack(alignment: .center, spacing: DesignSystem.Spacings.small) {
						Group {
							LocalImage(named: DesignSystem.Assets.calendarIcon, renderingMode: .template)
								.frame(width: 12, height: 12, alignment: .center)
							
							Text(viewModel.dueDate)
								.font(DesignSystem.Fonts.description)
						}
						.foregroundColor(viewModel.isDone ? DesignSystem.Colors.gray : viewModel.color)
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
	}
}

struct TaskRow_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			TaskRow(
				viewModel: .init(
					id: "1",
					text: "Task 1",
					dueDate: "Today",
					dueTimeInterval: 11111111,
					color: .red,
					isDone: false
				),
				isFirst: false,
				isLast: false
			)
			TaskRow(
				viewModel: .init(
					id: "1",
					text: "Task 2",
					dueDate: "Tomorrow",
					dueTimeInterval: 11111111,
					color: .red,
					isDone: true
				),
				isFirst: false,
				isLast: false
			)
		}
		.previewLayout(.sizeThatFits)
	}
}
