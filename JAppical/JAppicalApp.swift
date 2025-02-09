//
//  JAppicalApp.swift
//  JAppical
//
//  Created by Joao Pedro Franco on 05/02/25.
//

import SwiftUI
import JUI
import JData

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
