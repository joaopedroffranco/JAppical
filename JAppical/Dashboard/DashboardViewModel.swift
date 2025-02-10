// Created in 2025

import Foundation
import Combine
import JData

enum DashboardViewState: Equatable {
	case loading
	case data(thisMonthHires: [NewHireViewData]?)
}

@MainActor
class DashboardViewModel: ObservableObject {
	private let newHireService: NewHireServiceProtocol
	private let authenticationManager: AuthenticationManagerProtocol
	
	@Published var state: DashboardViewState = .loading

	var loggedUser: (avatar: URL?, name: String) {
		(avatar: authenticationManager.loggedUser?.avatar?.asUrl, name: authenticationManager.loggedUser?.name ?? "")
	}
	
	init(
		authenticationManager: AuthenticationManagerProtocol,
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
			state = .data(thisMonthHires: thisMonth.map { NewHireViewData(from: $0) })
		}
	}
}
