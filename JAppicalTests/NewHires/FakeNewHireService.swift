// Created in 2025

import Foundation
import JData

class FakeNewHireService: NewHireServiceProtocol {
	var thisMonthHires: [NewHire]?
	var allHires: [NewHire]?
	
	func getThisMonth() async -> [NewHire]? {
		thisMonthHires
	}
	
	func getAll() async -> [NewHire]? {
		allHires
	}
}

