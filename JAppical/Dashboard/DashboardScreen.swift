// Created in 2025

import SwiftUI
import JUI

struct DashboardScreen: View {
	@StateObject private var viewModel = DashboardViewModel()
	
	var body: some View {
		DashboardView(viewModel: viewModel)
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle(Strings.home)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) { Avatar() } // TODO: Get user avatar
			}
			.onAppear { viewModel.setup() }
	}
}
