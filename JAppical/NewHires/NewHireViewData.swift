// Created in 2025

import Foundation
import JData
import JUI

struct NewHireViewData: Hashable {
	let id: String
	let name: String
	let startDate: String
	let startTimeInterval: TimeInterval
	let avatar: URL?
	
	init(
		id: String = "",
		name: String,
		startDate: String,
		startTimeInterval: TimeInterval,
		avatar: URL? = nil
	) {
		self.id = id
		self.name = name
		self.startDate = startDate
		self.startTimeInterval = startTimeInterval
		self.avatar = avatar
	}
	
	init(from newHire: NewHire) {
		self.id = newHire.id
		self.name = newHire.name
		self.avatar = newHire.avatar?.asUrl
		self.startTimeInterval = newHire.startDate
		self.startDate = Strings.NewHires.firstDay(newHire.startDate.asDate.asString)
	}
}
