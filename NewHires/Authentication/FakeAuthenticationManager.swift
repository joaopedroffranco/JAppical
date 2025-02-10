// Created in 2025

import Foundation
import JData
@testable import JAppical

class FakeAuthenticationManager: AuthenticationManagerProtocol {
	var doesEmailExist: Bool = false
	var doesAuthenticate: Bool = false
	var didLogOut = false
	var loggedUser: User?
	
	func emailExists(_ email: String) async -> Bool { doesEmailExist }
	func authenticate(email: String, password: String) async -> Bool { doesAuthenticate }
	func logout() { didLogOut = true }
}
