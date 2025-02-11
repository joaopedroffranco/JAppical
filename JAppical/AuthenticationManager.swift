// Created in 2025

import Foundation
import JData

protocol AuthenticationManagerProtocol {
	var loggedUser: User? { get }

	func emailExists(_ email: String) async -> Bool
	func authenticate(email: String, password: String) async -> Bool
	func logout()
}

/// Manages the user authentication process, including login, logout, and email verification.
/// Conforms to the `AuthenticationManagerProtocol` and uses the `AuthenticationServiceProtocol`
/// to perform authentication operations.
///
/// **The `AuthenticationManager` class provides:**
/// - Verifying if an email exists in the system using the `emailExists` method.
/// - Authenticating a user by providing an email and password using the `authenticate` method.
/// - Logging out, removing the logged-in user using the `logout` method.
/// - Tracking the logged-in user state through the `loggedUser` property, which is automatically updated
///   when the user authenticates or logs out.
///
/// The class uses the `@Published` property to track the logged-in user and notify UI changes.
///
/// ```
/// let authManager = AuthenticationManager()
/// let emailExists = await authManager.emailExists("test@example.com") // Check if the email exists
/// let authenticated = await authManager.authenticate(email: "test@example.com", password: "password") // Authenticate user
/// authManager.logout() // Log the user out
/// ```
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
