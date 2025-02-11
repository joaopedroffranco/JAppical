// Created in 2025

import SwiftUI
import JUI

struct TodoTaskRow: View {
	@ObservedObject private var viewModel: TodoTaskRowViewModel
	private var didMark: () -> Void
	private var isFirst: Bool
	private var isLast: Bool
	
	init(viewModel: TodoTaskRowViewModel, isFirst: Bool, isLast: Bool, didMark: @escaping () -> Void = {}) {
		self.viewModel = viewModel
		self.didMark = didMark
		self.isFirst = isFirst
		self.isLast = isLast
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: .zero) {
			HStack(alignment: .top, spacing: DesignSystem.Spacings.default) {
				Checkbox(viewModel.isDone, didTap: didMark)
				
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

struct TodoTaskRow_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			TodoTaskRow(
				viewModel: .init(
					id: "1",
					text: "TodoTask 1",
					dueDate: "Today",
					dueTimeInterval: 11111111,
					color: .red,
					isDone: false
				),
				isFirst: false,
				isLast: false
			)
			TodoTaskRow(
				viewModel: .init(
					id: "1",
					text: "TodoTask 2",
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
