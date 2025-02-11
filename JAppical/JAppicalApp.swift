//
//  JAppicalApp.swift
//  JAppical
//
//  Created by Joao Pedro Franco on 05/02/25.
//

import SwiftUI
import JUI
import JData

/// The main entry point for the JAppical application, responsible for setting up the app's initial state and navigation flow.
///
/// The `JAppicalApp` struct is responsible for managing the app's lifecycle, including setting up the app's environment,
/// loading necessary resources, and determining which screen to show based on the user's authentication state.
///
/// **The `JAppicalApp` struct performs the following tasks:**
/// - Registers custom fonts with `FontLoader.registerFonts()` during initialization.
/// - Sets up the appearance of the navigation bar with `NavigationBarAppearance.setup()`.
/// - Fakes credentials using `UserDefaultsStorage` to store predefined email and password in `UserDefaults` for authentication purposes.
/// - Determines which screen to display on launch:
///   - If the user is not logged in, it presents the `LoginScreen`.
///   - If the user is logged in, it presents the `DashboardScreen` inside a `NavigationView`.
/// - The app uses the `authenticationManager` to track whether a user is logged in or not. Depending on the login status,
///   either the `LoginScreen` or `DashboardScreen` is displayed to the user.
@main
struct JAppicalApp: App {
	@StateObject private var authenticationManager = AuthenticationManager()
	
	init() {
		FontLoader.registerFonts()
		NavigationBarAppearance.setup()
		
		// Absurd. Faking credentials.
		let storage = UserDefaultsStorage()
		storage.set(Credentials.expectedEmail, forKey: Credentials.expectedEmailKey)
		storage.set(Credentials.expectedPassword, forKey: Credentials.expectedPasswordKey)
	}
	
	var body: some Scene {
		WindowGroup {
			if authenticationManager.loggedUser == nil {
				LoginScreen(authenticationManager: authenticationManager)
			} else {
				NavigationView {
					DashboardScreen(authenticationManager: authenticationManager)
				}
			}
		}
	}
}
