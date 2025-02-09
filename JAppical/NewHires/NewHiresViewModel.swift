// Created in 2025

import Foundation
import Combine
import JData

@MainActor
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
		newHires.sort { $0.startTimeInterval < $1.startTimeInterval }
	}
	
	func sortByLatest() {
		newHires.sort { $0.startTimeInterval > $1.startTimeInterval }
	}
}

// MARK: - Get
private extension NewHiresViewModel {
	func getNewHires() {
		Task {
			guard let newHires = await newHireService.getAll() else { newHires = []; return }
			self.newHires = newHires.map { NewHireViewData(from: $0) }
		}
	}
}
