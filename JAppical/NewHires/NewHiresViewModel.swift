// Created in 2025

import Foundation
import Combine
import JData

class NewHiresViewModel: ObservableObject {
	private let newHireService: NewHireServiceProtocol
	
	@Published var newHires: [NewHireViewData] = []
	
	init(
		newHireService: NewHireServiceProtocol = NewHireService()
	) {
		self.newHireService = newHireService
	}
	
	func setup() {
		getNewHires()
	}
	
	// MARK: - Sorting
	func sortByEarliest() {
		newHires.sort { $0.startDateTimeInterval < $1.startDateTimeInterval }
	}
	
	func sortByLatest() {
		newHires.sort { $0.startDateTimeInterval > $1.startDateTimeInterval }
	}
}

// MARK: - Get
private extension NewHiresViewModel {
	func getNewHires() {
		newHireService.getAll()
			.receive(on: DispatchQueue.main)
			.map { newHires in
				guard let newHires = newHires else { return [] }
				return newHires.map { NewHireViewData(from: $0) }.sorted { $0.startDateTimeInterval < $1.startDateTimeInterval }
			}
			.assign(to: &$newHires)
	}
}
