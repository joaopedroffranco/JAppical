// Created in 2025

import Foundation

public protocol AuthenticationServiceProtocol {
	func emailExists(_ email: String) async -> Bool
	func authenticate(email: String, password: String) async -> Bool
	func getUser() -> User?
	func logout()
}

public class AuthenticationService: AuthenticationServiceProtocol {
	private let storage: StorageProtocol
	
	public init(storage: StorageProtocol = UserDefaultsStorage()) {
		self.storage = storage
	}
	
	// !!!
	// This is a fake absurd logic to simulate an authentication by checking with an expected credentials.
	// A safe way would be having an OAuth API, and it'd just send credentials and get back a valid token.
	// !!!
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

