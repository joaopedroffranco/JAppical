// Created in 2025

import SwiftUI

struct LoginScreen: View {
	@StateObject private var viewModel: LoginViewModel
	
	init(authenticationManager: AuthenticationManager) {
		_viewModel = StateObject(wrappedValue: LoginViewModel(authenticationManager: authenticationManager))
	}
	
	var body: some View {
		LoginView(viewModel: viewModel)
	}
}
