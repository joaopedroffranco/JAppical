// Created in 2025

import XCTest
import JData
import Combine
@testable import JAppical

class TodoTaskViewModelTests: XCTestCase {
	private var cancellables: Set<AnyCancellable> = []

	// MARK: - Setup
	func testSetup() async throws {
		// given
		let tasks = TodoTaskStubs.many
		let service = FakeTodoTaskService()
		let viewModel = await TodoTasksViewModel(taskService: service)
		service.tasks = tasks
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedState: TodoTasksViewState = .allCompleted
		await viewModel.$state
			.dropFirst()
			.sink { state in
				expectedState = state
				expectation.fulfill()
			}
			.store(in: &cancellables)
		
		XCTAssertEqual(expectedState, .allCompleted)
		await viewModel.setup()
		
		wait(for: [expectation], timeout: 1)

		// then
		XCTAssertEqual(expectedState, .todoTasks(tasks.asRowData))
	}
	
	func testSetupAndAllCompleted() async throws {
		// given
		let tasks = TodoTaskStubs.manyAndCompleted
		let service = FakeTodoTaskService()
		let viewModel = await TodoTasksViewModel(taskService: service)
		service.tasks = tasks
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedState: TodoTasksViewState = .allCompleted
		await viewModel.$state
			.dropFirst()
			.sink { state in
				expectedState = state
				expectation.fulfill()
			}
			.store(in: &cancellables)
		
		XCTAssertEqual(expectedState, .allCompleted)
		await viewModel.setup()
		
		wait(for: [expectation], timeout: 1)

		// then
		XCTAssertEqual(expectedState, .allCompleted)
	}
	
	func testSetupWithNoTasks() async throws {
		// given
		let service = FakeTodoTaskService()
		let viewModel = await TodoTasksViewModel(taskService: service)
		service.tasks = [:]
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedState: TodoTasksViewState = .allCompleted
		await viewModel.$state
			.dropFirst()
			.sink { state in
				expectedState = state
				expectation.fulfill()
			}
			.store(in: &cancellables)
		
		XCTAssertEqual(expectedState, .allCompleted)
		await viewModel.setup()
		
		wait(for: [expectation], timeout: 1)

		// then
		XCTAssertEqual(expectedState, .allCompleted)
	}
	
	// MARK: - Check
	func testDidCheck() async throws {
		// given
		let tasks = TodoTaskStubs.many
		let service = FakeTodoTaskService()
		let viewModel = await TodoTasksViewModel(taskService: service)
		service.tasks = tasks
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedState: TodoTasksViewState = .allCompleted
		await viewModel.$state
			.dropFirst()
			.sink { state in
				expectedState = state
				expectation.fulfill()
			}
			.store(in: &cancellables)
		
		XCTAssertEqual(expectedState, .allCompleted)
		await viewModel.setup()
		XCTAssertFalse(expectedState.isChecked(for: "1") ?? false)
		wait(for: [expectation], timeout: 1)

		await viewModel.didCheck(taskId: "1")

		// then
		XCTAssertTrue(expectedState.isChecked(for: "1") ?? false)
	}
	
	func testDidUnCheck() async throws {
		// given
		let tasks = TodoTaskStubs.many
		let service = FakeTodoTaskService()
		let viewModel = await TodoTasksViewModel(taskService: service)
		service.tasks = tasks
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedState: TodoTasksViewState = .allCompleted
		await viewModel.$state
			.dropFirst()
			.sink { state in
				expectedState = state
				expectation.fulfill()
			}
			.store(in: &cancellables)
		
		XCTAssertEqual(expectedState, .allCompleted)
		await viewModel.setup()
		XCTAssertFalse(expectedState.isChecked(for: "1") ?? false)
		wait(for: [expectation], timeout: 1)

		await viewModel.didCheck(taskId: "1")
		await viewModel.didCheck(taskId: "1")

		// then
		XCTAssertFalse(expectedState.isChecked(for: "1") ?? false)
	}
	
	func testDidCheckThenAllCompleted() async throws {
		// given
		let tasks = TodoTaskStubs.many
		let service = FakeTodoTaskService()
		let viewModel = await TodoTasksViewModel(taskService: service)
		service.tasks = tasks
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedState: TodoTasksViewState = .allCompleted
		await viewModel.$state
			.dropFirst()
			.sink { state in
				expectedState = state
				expectation.fulfill()
			}
			.store(in: &cancellables)
		
		XCTAssertEqual(expectedState, .allCompleted)
		await viewModel.setup()
		XCTAssertFalse(expectedState.isChecked(for: "1") ?? false)
		wait(for: [expectation], timeout: 1)

		await viewModel.didCheck(taskId: "1")
		await viewModel.didCheck(taskId: "2")

		// then
		XCTAssertNil(expectedState.isChecked(for: "1"))
		XCTAssertNil(expectedState.isChecked(for: "2"))
		XCTAssertEqual(expectedState, .allCompleted)
	}
}
