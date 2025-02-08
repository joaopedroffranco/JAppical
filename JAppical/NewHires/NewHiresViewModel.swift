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
}

private extension NewHiresViewModel {
	func getNewHires() {
		newHireService.getAll()
			.receive(on: DispatchQueue.main)
			.map { newHires in
				guard let newHires = newHires else { return [] }
				return newHires.map { NewHireViewData(from: $0) }
			}
			.assign(to: &$newHires)
	}
}
