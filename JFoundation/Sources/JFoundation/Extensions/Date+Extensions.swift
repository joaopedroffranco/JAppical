//
// Created by Joao Pedro Franco on 25/09/24
//

import Foundation

public extension Date {
	var asString: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MM yyyy"
		
		return formatter.string(from: self)
	}
	
	var isToday: Bool {
		Calendar.current.isDateInToday(self)
	}
	
	var isTomorrow: Bool {
		Calendar.current.isDateInTomorrow(self)
	}
}

public extension TimeInterval {
	var asDate: Date { Date(timeIntervalSince1970: self) }
}
