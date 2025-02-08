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
//			NavigationView {
//				 DashboardScreen() // TODO: Check authentication
//			}
			
			
			LoginScreen()
		}
	}
}
