// Created in 2025

import XCTest
import JData
import Combine
@testable import JAppical

class DashboardViewModelTests: XCTestCase {
	private var cancellables: Set<AnyCancellable> = []

	// MARK: - Setup
	func testSetup() async throws {
		// given
		let thisMonthHires = NewHireStubs.many
		let manager = FakeAuthenticationManager()
		let service = FakeNewHireService()
		let viewModel = await DashboardViewModel(authenticationManager: manager, newHireService: service)
		service.thisMonthHires = thisMonthHires
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedState: DashboardViewState = .loading
		await viewModel.$state
			.dropFirst()
			.sink { state in
				expectedState = state
				expectation.fulfill()
			}
			.store(in: &cancellables)

		XCTAssertEqual(expectedState, .loading)
		await viewModel.setup()
		
		wait(for: [expectation], timeout: 1)
		// then
		XCTAssertEqual(expectedState, .data(thisMonthHires: thisMonthHires.map { NewHireViewData(from: $0) }))
	}
	
	func testSetupWithNoHire() async throws {
		// given
		let manager = FakeAuthenticationManager()
		let service = FakeNewHireService()
		let viewModel = await DashboardViewModel(authenticationManager: manager, newHireService: service)
		service.thisMonthHires = nil
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedState: DashboardViewState = .loading
		await viewModel.$state
			.dropFirst()
			.sink { state in
				expectedState = state
				expectation.fulfill()
			}
			.store(in: &cancellables)

		XCTAssertEqual(expectedState, .loading)
		await viewModel.setup()
		
		wait(for: [expectation], timeout: 1)
		// then
		XCTAssertEqual(expectedState, .data(thisMonthHires: nil))
	}
	
	// MARK: - Authentication
	func testLogOut() async throws {
		// given
		let manager = FakeAuthenticationManager()
		let service = FakeNewHireService()
		let viewModel = await DashboardViewModel(authenticationManager: manager, newHireService: service)
		
		// when
		XCTAssertFalse(manager.didLogOut)
		await viewModel.logout()

		// then
		XCTAssertTrue(manager.didLogOut)
	}
	
	func testLoggedUser() async throws {
		// given
		let user = UserStubs.instance
		let manager = FakeAuthenticationManager()
		let service = FakeNewHireService()
		let viewModel = await DashboardViewModel(authenticationManager: manager, newHireService: service)
		manager.loggedUser = user
		
		// when
		let userData = await viewModel.loggedUser

		// then
		XCTAssertEqual(userData.avatar, user.avatar?.asUrl)
		XCTAssertEqual(userData.name, user.name)
	}
	
	
}
