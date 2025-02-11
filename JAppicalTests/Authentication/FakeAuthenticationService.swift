// Created in 2025

import Foundation
import JData

class FakeAuthenticationService: AuthenticationServiceProtocol {
	var doesEmailExist: Bool = false
	var doesAuthenticate: Bool = false
	var willLoginUser: User?
	var didLogOut = false
	
	func emailExists(_ email: String) async -> Bool {
		doesEmailExist
	}
	
	func authenticate(email: String, password: String) async -> Bool {
		doesAuthenticate
	}
	
	func getUser() -> User? {
		willLoginUser
	}
	
	func logout() {
		didLogOut = true
	}
}
