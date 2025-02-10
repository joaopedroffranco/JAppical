// Created in 2025

import SwiftUI
import JUI

struct DashboardScreen: View {
	@StateObject private var viewModel: DashboardViewModel
	@State var showLogoutOption = false
	
	init(authenticationManager: AuthenticationManagerProtocol) {
		_viewModel = StateObject(wrappedValue: DashboardViewModel(authenticationManager: authenticationManager))
	}
	
	var body: some View {
		DashboardView(viewModel: viewModel)
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle(Strings.home)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Avatar(id: "user_\(viewModel.loggedUser.name)", image: viewModel.loggedUser.avatar)
						.onTapGesture { showLogoutOption = true }
						.confirmationDialog("", isPresented: $showLogoutOption, titleVisibility: .hidden) {
							Button(Strings.Login.loginOut) { viewModel.logout() }
						}
				}
			}
			.onFirstAppear { viewModel.setup() }
	}
}
