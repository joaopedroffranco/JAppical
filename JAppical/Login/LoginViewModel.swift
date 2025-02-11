// Created in 2025

import Foundation
import JData
import JUI

enum LoginViewState {
	case inputEmail
	case emailInvalid
	case emailNotExist
	case emailLoading
	case inputPassword
	case wrongPassword
	case authenticationLoading
}

/// A view model responsible for handling the login process, including validating the email,
/// authenticating the user, and managing the UI state for login.
///
/// This class interacts with the `AuthenticationManagerProtocol` to verify the existence of an email
/// and perform user authentication. It updates the `LoginViewState` based on the input and authentication result,
/// and provides error messages for invalid input or incorrect credentials.
///
/// The class uses `@MainActor` to ensure UI updates are performed on the main thread.
///
/// ```
/// let loginViewModel = LoginViewModel(authenticationManager: authenticationManager)
/// loginViewModel.validateEmail() // Validate the entered email
/// loginViewModel.authenticate() // Authenticate the user
/// ```
@MainActor
class LoginViewModel: ObservableObject {
	private let authenticationManager: AuthenticationManagerProtocol
	
	@Published var inputEmail: String = ""
	@Published var inputPassword: String = ""
	@Published var state: LoginViewState = .inputEmail
	
	var emailErrorMessage: String? {
		switch state {
		case .emailInvalid: return Strings.Login.Errors.emailInvalid
		case .emailNotExist: return Strings.Login.Errors.emailNotExist
		default: return nil
		}
	}

	var isPasswordVisible: Bool {
		state == .inputPassword || state == .wrongPassword || state == .authenticationLoading
	}
	
	var passwordErrorMessage: String? {
		switch state {
		case .wrongPassword: return Strings.Login.Errors.wrongPassword
		default: return nil
		}
	}
	
	init(authenticationManager: AuthenticationManagerProtocol) {
		self.authenticationManager = authenticationManager
	}
	
	func validateEmail() {
		state = .emailLoading
		Task {
			guard inputEmail.isValidEmail else {
				state = .emailInvalid
				return
			}

			state = .emailLoading
			guard await authenticationManager.emailExists(inputEmail) else {
				state = .emailNotExist
				return
			}

			state = .inputPassword
		}
	}
	
	func authenticate() {
		state = .authenticationLoading
		
		Task {
			guard await authenticationManager.authenticate(email: inputEmail, password: inputPassword) else {
				state = .wrongPassword
				return
			}
			
			state = .authenticationLoading
		}
	}
}
