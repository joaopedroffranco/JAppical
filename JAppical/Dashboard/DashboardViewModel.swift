// Created in 2025

import Foundation
import Combine
import JData

enum DashboardViewState {
	case loading
	case data(thisMonthHires: [URL?]?)
}

@MainActor
class DashboardViewModel: ObservableObject {
	private let newHireService: NewHireServiceProtocol
	private let authenticationManager: AuthenticationManager
	
	@Published var state: DashboardViewState = .loading
	var loggedUser: (avatar: URL?, name: String) {
		(avatar: authenticationManager.loggedUser?.avatar?.asUrl, name: authenticationManager.loggedUser?.name ?? "")
	}
	
	init(
		authenticationManager: AuthenticationManager,
		newHireService: NewHireServiceProtocol = NewHireService()
	) {
		self.newHireService = newHireService
		self.authenticationManager = authenticationManager
	}
	
	func setup() {
		getThisMonthHires()
	}
	
	func logout() {
		authenticationManager.logout()
	}
}

private extension DashboardViewModel {
	func getThisMonthHires() {
		Task {
			guard let thisMonth = await newHireService.getThisMonth() else { state = .data(thisMonthHires: nil); return }
			let thisMonthHires = thisMonth.map { $0.avatar?.asUrl }
			state = .data(thisMonthHires: thisMonthHires)
		}
	}
}
