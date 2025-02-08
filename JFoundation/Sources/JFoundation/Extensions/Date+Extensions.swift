//
// Created by Joao Pedro Franco on 25/09/24
//

import Foundation

public extension Date {
	var asString: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "d MMM yyyy"
		formatter.locale = Locale(identifier: "en_US")
		
		return formatter.string(from: self)
	}
	
	var isToday: Bool {
		Calendar.current.isDateInToday(self)
	}
	
	var isTomorrow: Bool {
		Calendar.current.isDateInTomorrow(self)
	}
	
	var isThisMonth: Bool {
		let calendar = Calendar.current
		let currentDate = Date.now
		
		let currentMonth = calendar.component(.month, from: currentDate)
		let currentYear = calendar.component(.year, from: currentDate)

		let givenMonth = calendar.component(.month, from: self)
		let givenYear = calendar.component(.year, from: self)
		
		return currentMonth == givenMonth && currentYear == givenYear
	}
}

public extension TimeInterval {
	var asDate: Date { Date(timeIntervalSince1970: self) }
}
