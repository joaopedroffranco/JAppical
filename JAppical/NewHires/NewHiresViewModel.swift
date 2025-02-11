// Created in 2025

import Foundation
import Combine
import JData

/// A view model responsible for managing the list of new hires and providing functionality
/// for sorting and fetching new hire data.
///
/// This class interacts with the `NewHireServiceProtocol` to retrieve the list of new hires,
/// and provides sorting functionality based on the hire's start date. It updates the list of new hires
/// in the `newHires` property, and ensures that the data is loaded asynchronously.
///
/// The class uses `@MainActor` to ensure UI updates are performed on the main thread.
///
/// ```
/// let newHiresViewModel = NewHiresViewModel()
/// newHiresViewModel.setup() // Fetch new hires
/// newHiresViewModel.sortByEarliest() // Sort by earliest start date
/// newHiresViewModel.sortByLatest() // Sort by latest start date
/// ```
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
