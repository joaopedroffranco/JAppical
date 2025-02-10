// Created in 2025

import Foundation
import JData

protocol AuthenticationManagerProtocol {
	var loggedUser: User? { get }

	func emailExists(_ email: String) async -> Bool
	func authenticate(email: String, password: String) async -> Bool
	func logout()
}

class AuthenticationManager: ObservableObject, AuthenticationManagerProtocol {
	private let service: AuthenticationServiceProtocol
	
	@Published var loggedUser: User?
	
	init(service: AuthenticationServiceProtocol = AuthenticationService()) {
		self.service = service
		loggedUser = service.getUser()
	}

	func emailExists(_ email: String) async -> Bool {
		await service.emailExists(email)
	}
	
	func authenticate(email: String, password: String) async -> Bool {
		guard await service.authenticate(email: email, password: password) else { return false }
		loggedUser = service.getUser()

		return true
	}
	
	func logout() {
		service.logout()
		loggedUser = nil
	}
}
