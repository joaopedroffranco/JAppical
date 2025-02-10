// Created in 2025

import XCTest
import JData
import Combine
@testable import JAppical

class NewHireViewModelTests: XCTestCase {
	private var cancellables: Set<AnyCancellable> = []

	func testSetup() async throws {
		// given
		let newHires = NewHireStubs.many
		let service = FakeNewHireService()
		let viewModel = await NewHiresViewModel(newHireService: service)
		service.allHires = newHires
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedNewHiresData: [NewHireViewData] = []
		await viewModel.$newHires
			.dropFirst()
			.sink { data in
				expectedNewHiresData = data
				expectation.fulfill()
			}
			.store(in: &cancellables)

		XCTAssertEqual(expectedNewHiresData, [])
		await viewModel.setup()
		
		wait(for: [expectation], timeout: 1)
		// then
		XCTAssertEqual(expectedNewHiresData, newHires.map { NewHireViewData(from: $0) })
	}
	
	func testSetupWithNoHires() async throws {
		// given
		let service = FakeNewHireService()
		let viewModel = await NewHiresViewModel(newHireService: service)
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedNewHiresData: [NewHireViewData] = []
		await viewModel.$newHires
			.dropFirst()
			.sink { data in
				expectedNewHiresData = data
				expectation.fulfill()
			}
			.store(in: &cancellables)

		XCTAssertEqual(expectedNewHiresData, [])
		await viewModel.setup()
		
		wait(for: [expectation], timeout: 1)
		// then
		XCTAssertEqual(expectedNewHiresData, [])
	}
	
	// MARK: - Sorting
	func testSortByEarlist() async throws {
		// given
		let newHires = NewHireStubs.many
		let service = FakeNewHireService()
		let viewModel = await NewHiresViewModel(newHireService: service)
		service.allHires = newHires
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedSortedNewHiresData: [NewHireViewData] = []
		await viewModel.$newHires
			.dropFirst(2)
			.sink { sortedData in
				expectedSortedNewHiresData = sortedData
				expectation.fulfill()
			}
			.store(in: &cancellables)

		await viewModel.setup()
		await viewModel.sortByEarliest()
		
		wait(for: [expectation], timeout: 1)
		// then
		XCTAssertEqual(
			expectedSortedNewHiresData.map { $0.id },
			newHires
				.map { NewHireViewData(from: $0) }
				.sorted { $0.startTimeInterval < $1.startTimeInterval }
				.map { $0.id }
		)
	}
	
	func testSortByLatest() async throws {
		// given
		let newHires = NewHireStubs.many
		let service = FakeNewHireService()
		let viewModel = await NewHiresViewModel(newHireService: service)
		service.allHires = newHires
		
		// when
		let expectation = XCTestExpectation(description: "Getting...")
		var expectedSortedNewHiresData: [NewHireViewData] = []
		await viewModel.$newHires
			.dropFirst(2)
			.sink { sortedData in
				expectedSortedNewHiresData = sortedData
				expectation.fulfill()
			}
			.store(in: &cancellables)

		await viewModel.setup()
		await viewModel.sortByLatest()
		
		wait(for: [expectation], timeout: 1)
		// then
		XCTAssertEqual(
			expectedSortedNewHiresData.map { $0.id },
			newHires
				.map { NewHireViewData(from: $0) }
				.sorted { $0.startTimeInterval > $1.startTimeInterval }
				.map { $0.id }
		)
	}
}
