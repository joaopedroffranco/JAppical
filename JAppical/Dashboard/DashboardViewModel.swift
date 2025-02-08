// Created in 2025

import Foundation
import Combine
import JData

class DashboardViewModel: ObservableObject {
	private let newHireService: NewHireServiceProtocol
	private let userService: UserServiceProtocol
	
	@Published var thisMonthHires: [URL?] = []
	@Published var loggedUser: (avatar: URL?, name: String) = (nil, "")
	
	init(
		newHireService: NewHireServiceProtocol = NewHireService(),
		userService: UserServiceProtocol = UserService()
	) {
		self.newHireService = newHireService
		self.userService = userService
	}
	
	func setup() {
		getUser()
		getThisMonthHires()
	}
	
	func logout() {
		userService.logout()
	}
}

private extension DashboardViewModel {
	func getUser() {
		guard let user = userService.getLoggedUser() else { return }
		loggedUser = (avatar: user.avatar?.asUrl, name: user.name)
	}
	
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
