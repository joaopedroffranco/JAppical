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
	case logged
}

class LoginViewModel: ObservableObject {
	private let service: UserServiceProtocol
	
	@Published var inputEmail: String = ""
	@Published var inputPassword: String = ""
	@Published var state: LoginViewState = .inputEmail
	
	var isEmailEnabled: Bool {
		state == .emailLoading || state == .inputEmail || state == .emailInvalid || state == .emailNotExist
	}
	
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
	
	init(service: UserServiceProtocol = UserService()) {
		self.service = service
	}
	
	func validateEmail() {
		switch state {
		case .inputEmail, .emailInvalid, .emailNotExist:
			guard inputEmail.isValidEmail else { return state = .emailInvalid }
			state = .emailLoading
			Task {
				guard await service.emailExists(inputEmail) else {
					Task { @MainActor in state = .emailNotExist }
					return
				}
				Task { @MainActor in state = .inputPassword }
			}
		default: return
		}
	}
	
	func authenticate() {
		switch state {
		case .inputPassword, .wrongPassword:
			state = .authenticationLoading
			Task {
				guard await service.authenticate(email: inputEmail, password: inputPassword) else {
					Task { @MainActor in state = .wrongPassword }
					return
				}
				
				Task { @MainActor in state = .logged }
			}
		default: return
		}
	}
}
