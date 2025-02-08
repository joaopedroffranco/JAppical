// Created in 2025

import Foundation
import JData
import JUI

struct NewHireViewData: Hashable {
	let id: String
	let name: String
	let startDate: String
	let avatar: URL?
	
	init(
		id: String = "",
		name: String,
		startDate: String,
		avatar: URL? = nil
	) {
		self.id = id
		self.name = name
		self.startDate = startDate
		self.avatar = avatar
	}
	
	init(from newHire: NewHire) {
		self.id = newHire.id
		self.name = newHire.name
		self.avatar = newHire.avatar?.asUrl
		self.startDate = Strings.NewHires.firstDay(newHire.startDate.asDate.asString)
	}
}
