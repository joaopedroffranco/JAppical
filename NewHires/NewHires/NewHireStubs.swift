// Created in 2025

import Foundation
import JData

enum NewHireStubs {
	static let instance = NewHire(id: "1", name: "Joao", startDate: 12345678, avatar: nil)
	
	static let many = [
		NewHire(id: "1", name: "Joao", startDate: 2, avatar: nil),
		NewHire(id: "2", name: "Pedro", startDate: 1, avatar: nil),
		NewHire(id: "3", name: "Franco", startDate: 3, avatar: nil)
	]
}
