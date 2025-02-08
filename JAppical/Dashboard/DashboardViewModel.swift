// Created in 2025

import Foundation
import Combine
import JData

class DashboardViewModel: ObservableObject {
	private let newHireService: NewHireServiceProtocol
	
	@Published var thisMonthHires: [URL?] = []
	
	init(
		newHireService: NewHireServiceProtocol = NewHireService()
	) {
		self.newHireService = newHireService
	}
	
	func setup() {
		getThisMonthHires()
	}
}

private extension DashboardViewModel {
	func getThisMonthHires() {
		newHireService.getThisMonth()
			.receive(on: DispatchQueue.main)
			.map { thisMonth in
				guard let thisMonth = thisMonth else { return [] }
				return thisMonth.map { $0.avatar?.asUrl }
			}
			.assign(to: &$thisMonthHires)
	}
}
