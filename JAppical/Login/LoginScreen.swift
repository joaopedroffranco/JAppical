// Created in 2025

import SwiftUI

struct LoginScreen: View {
	@StateObject var viewModel = LoginViewModel()

	var body: some View {
		LoginView(viewModel: viewModel)
	}
}
