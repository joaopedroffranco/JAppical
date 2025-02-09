// Created in 2025

import SwiftUI
import JUI

struct LoginView: View {
	@ObservedObject var viewModel: LoginViewModel
	
	var body: some View {
		VStack {
			header
				.padding(.vertical, 64)
			
			VStack(alignment: .center, spacing: DesignSystem.Spacings.largeMargin) {
				email
				if viewModel.isPasswordVisible { password }
			}
			.padding(.horizontal, 32)
			
			Spacer()
			button
			Spacer()
		}
	}
}

private extension LoginView {
	@ViewBuilder
	var header: some View {
		VStack(alignment: .center, spacing: DesignSystem.Spacings.margin) {
			LocalImage(named: DesignSystem.Assets.logo)
				.scaledToFit()
				.frame(height: 89)
			Text(Strings.Login.title)
				.font(DesignSystem.Fonts.title)
		}
	}
	
	@ViewBuilder
	var email: some View {
		VStack(alignment: .leading, spacing: DesignSystem.Spacings.default) {
			Text(Strings.Login.email)
				.font(DesignSystem.Fonts.description)
				.foregroundColor(DesignSystem.Colors.gray)

			JTextField(text: $viewModel.inputEmail, errorMessage: viewModel.emailErrorMessage)
				.keyboardType(.emailAddress)
				.textInputAutocapitalization(.never)
		}
		
	}
	
	@ViewBuilder
	var password: some View {
		VStack(alignment: .leading, spacing: DesignSystem.Spacings.default) {
			Text(Strings.Login.password)
				.font(DesignSystem.Fonts.description)
			
			.foregroundColor(DesignSystem.Colors.gray)
			JSecureTextField(text: $viewModel.inputPassword, errorMessage: viewModel.passwordErrorMessage)
		}
	}
	
	@ViewBuilder
	var button: some View {
		switch viewModel.state {
		case .inputEmail, .emailNotExist, .emailInvalid:
			JButton(
				text: Strings.Login.next,
				backgroundColor: DesignSystem.Colors.primary,
				foregroundColor: DesignSystem.Colors.white
			) { viewModel.validateEmail() }
			.frame(width: 146, height: 42)
		case .inputPassword, .wrongPassword:
			JButton(
				text: Strings.Login.loginIn,
				backgroundColor: DesignSystem.Colors.primary,
				foregroundColor: DesignSystem.Colors.white
			) { viewModel.authenticate() }
			.frame(width: 146, height: 42)
		case .authenticationLoading, .emailLoading:
			Loading()
		default: EmptyView()
		}
	}
}

//struct LoginView_Previews: PreviewProvider {
//	static var previews: some View {
//		LoginView
//	}
//}
