// Created in 2025

import Foundation
import JData

public class AuthenticationManager: ObservableObject {
	private let service: AuthenticationServiceProtocol
	
	@Published public var loggedUser: User?
	
	public init(service: AuthenticationServiceProtocol = AuthenticationService()) {
		self.service = service
		loggedUser = service.getUser()
	}

	public func emailExists(_ email: String) async -> Bool {
		await service.emailExists(email)
	}
	
	public func authenticate(email: String, password: String) async -> Bool {
		guard await service.authenticate(email: email, password: password) else { return false }
		loggedUser = service.getUser()

		return true
	}
	
	public func logout() {
		service.logout()
		loggedUser = nil
	}
}
