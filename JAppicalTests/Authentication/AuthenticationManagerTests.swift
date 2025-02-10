// Created in 2025

import XCTest
import JData
@testable import JAppical

class AuthenticationManagerTests: XCTestCase {
	func testLogin() async throws {
		// given
		let service = FakeAuthenticationService()
		let manager = AuthenticationManager(service: service)
		service.doesAuthenticate = true
		service.doesEmailExist = true
		let expectedUser = User(id: "1", name: "Test")
		service.willLoginUser = expectedUser
		
		// when
		let isExisted = await manager.emailExists("valid_email")
		let didAuthenticate = await manager.authenticate(email: "valid_email", password: "valid_password")
		
		// then
		XCTAssertTrue(isExisted)
		XCTAssertTrue(didAuthenticate)
		XCTAssertEqual(expectedUser, manager.loggedUser)
	}
	
	func testEmailDoesntExist() async throws {
		// given
		let service = FakeAuthenticationService()
		let manager = AuthenticationManager(service: service)
		service.doesEmailExist = false
		
		// when
		let isExisted = await manager.emailExists("invalid_email")
		
		// then
		XCTAssertFalse(isExisted)
	}
	
	func testPasswordWrong() async throws {
		// given
		let service = FakeAuthenticationService()
		let manager = AuthenticationManager(service: service)
		service.doesAuthenticate = false
		
		// when
		let didAuthenticate = await manager.authenticate(email: "valid_email", password: "wrong_password")
		
		// then
		XCTAssertFalse(didAuthenticate)
	}
	
	func testLogOut() async throws {
		// given
		let service = FakeAuthenticationService()
		let manager = AuthenticationManager(service: service)
		
		// when
		manager.logout()
		
		// then
		XCTAssertTrue(service.didLogOut)
	}
}
