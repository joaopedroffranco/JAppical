// Created in 2025

import SwiftUI
import JUI

struct NewHiresView: View {
	@ObservedObject var viewModel: NewHiresViewModel
	
	private var count: Int { data.count }
	private var data: [NewHireViewData] { viewModel.newHires }
	
	init(viewModel: NewHiresViewModel) {
		self.viewModel = viewModel
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: .zero) {
			Text(Strings.NewHires.title)
				.font(DesignSystem.Fonts.heading)
				.padding(.top, 32)
				.padding(.bottom, DesignSystem.Spacings.margin)

			JList(data: data) { offset, hire in hireView(hire, isLast: offset == count - 1) }
			  .cornerRadius(DesignSystem.Radius.small)
		}
		.padding(.horizontal, DesignSystem.Spacings.margin)
		.padding(.bottom, DesignSystem.Spacings.margin)
		.background(DesignSystem.Colors.lightGray)
	}
}

private extension NewHiresView {
	@ViewBuilder
	func hireView(_ newHire: NewHireViewData, isLast: Bool) -> some View {
		VStack(alignment: .leading, spacing: .zero) {
			HStack(spacing: DesignSystem.Spacings.margin) {
				Avatar(id: newHire.id, image: newHire.avatar, borderColor: DesignSystem.Colors.border)
				
				VStack(alignment: .leading, spacing: DesignSystem.Spacings.small) {
					Text(newHire.name)
						.font(DesignSystem.Fonts.default)
					
					Text(newHire.startDate)
						.font(DesignSystem.Fonts.description)
						.foregroundColor(DesignSystem.Colors.gray)
					
					Button {} label: {
						Text(Strings.NewHires.sendMessage)
							.font(DesignSystem.Fonts.description)
							.foregroundColor(DesignSystem.Colors.primary)
					}
				}
			}
			.padding(.horizontal, DesignSystem.Spacings.largeMargin)
			.padding(.vertical, DesignSystem.Spacings.margin)
			
			if !isLast {
				Separator()
			}
		}
	}
}

struct NewHiresView_Previews: PreviewProvider {
	static let data: [NewHireViewData] = [
		.init(id: "1", name: "Joao", startDate: "First Day 15 Feb 2025", startTimeInterval: 1, avatar: nil),
		.init(id: "2", name: "Pedro", startDate: "First Day 15 Feb 2025", startTimeInterval: 2, avatar: nil),
		.init(id: "3", name: "Franco", startDate: "First Day 15 Feb 2025", startTimeInterval: 3, avatar: nil)
	]
	
	static let viewModel: NewHiresViewModel = {
		let viewModel = NewHiresViewModel()
		viewModel.newHires = data
		return viewModel
	}()

	static var previews: some View {
		NewHiresView(viewModel: viewModel)
	}
}
