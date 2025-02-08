// Created in 2025

import SwiftUI
import JUI

struct NewHiresScreen: View {
	@State var viewModel = NewHiresViewModel()
	@State var showSortingOptions = false
	
	var body: some View {
		NewHiresView(viewModel: viewModel)
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle(Strings.newsHires)
			.navigationBarBackButtonHidden(false)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button { showSortingOptions = true } label: {
						LocalImage(named: DesignSystem.Assets.sortIcon)
							.scaledToFit()
							.frame(width: 24, height: 24, alignment: .center)
					}
					.confirmationDialog("", isPresented: $showSortingOptions, titleVisibility: .hidden) {
						Button(Strings.NewHires.sortEarliest) { viewModel.sortByEarliest() }
						Button(Strings.NewHires.sortLatest) { viewModel.sortByLatest() }
					}
				}
			}
			.onAppear { viewModel.setup() }
	}
}
