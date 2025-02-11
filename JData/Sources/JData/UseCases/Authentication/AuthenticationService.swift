// Created in 2025

import Foundation

public protocol AuthenticationServiceProtocol {
	func emailExists(_ email: String) async -> Bool
	func authenticate(email: String, password: String) async -> Bool
	func getUser() -> User?
	func logout()
}

/// A concrete implementation of the `AuthenticationServiceProtocol` that handles user authentication logic.
///
/// The `AuthenticationService` class provides methods for verifying if an email exists, authenticating users, and
/// managing user sessions. It uses a storage mechanism (`StorageProtocol`) for saving and retrieving user-related data
/// from a persistent store like `UserDefaults`. This service includes basic authentication checks for simulating login
/// actions with hardcoded credentials, but can be extended to implement more secure methods like OAuth-based authentication.
///
/// This class provides:
/// - A method to check if a specific email exists in the storage.
/// - A method to authenticate a user with email and password, and save their session.
/// - A method to get the currently logged-in user.
/// - A method to log out a user by removing their session data from storage.
///
/// **Note**: The authentication process used here is for simulation purposes and uses predefined credentials. For a
/// real-world application, you would use a secure API or OAuth system.
///
/// ```
/// let authService = AuthenticationService()
/// let exists = await authService.emailExists("user@example.com")
/// let isAuthenticated = await authService.authenticate(email: "user@example.com", password: "password123")
/// let user = authService.getUser()
/// authService.logout()
/// ```
public class AuthenticationService: AuthenticationServiceProtocol {
	private let storage: StorageProtocol
	
	public init(storage: StorageProtocol = UserDefaultsStorage()) {
		self.storage = storage
	}

	public func emailExists(_ email: String) async -> Bool {
		storage.get(forKey: Credentials.expectedEmailKey) == email
	}
	
	public func authenticate(email: String, password: String) async -> Bool {
		guard storage.get(forKey: Credentials.expectedEmailKey) == email &&
						storage.get(forKey: Credentials.expectedPasswordKey) == password else { return false }
		
		storage.set(Credentials.loggedUser, forKey: Credentials.loggedUserKey)
		return true
	}
	
	public func getUser() -> User? {
		storage.get(forKey: Credentials.loggedUserKey)
	}
	
	public func logout() {
		storage.remove(forKey: Credentials.loggedUserKey)
	}
}

