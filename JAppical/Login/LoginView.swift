// Created in 2025

import SwiftUI
import JUI

struct LoginView: View {
	var body: some View {
		VStack {
			header
				.padding(.vertical, 64)
			
			VStack(alignment: .center, spacing: DesignSystem.Spacings.largeMargin) {
				email
				password
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
			JTextField()
				.keyboardType(.emailAddress)
		}
	}
	
	@ViewBuilder
	var password: some View {
		VStack(alignment: .leading, spacing: DesignSystem.Spacings.default) {
			Text(Strings.Login.password)
				.font(DesignSystem.Fonts.description)
			
			.foregroundColor(DesignSystem.Colors.gray)
			JSecureTextField()
		}
	}
	
	@ViewBuilder
	var button: some View {
		JButton(
			text: Strings.Login.loginIn,
			backgroundColor: DesignSystem.Colors.primary,
			foregroundColor: DesignSystem.Colors.white
		)
		.frame(width: 146, height: 42)
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}
