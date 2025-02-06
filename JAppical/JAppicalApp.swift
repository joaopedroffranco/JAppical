//
//  JAppicalApp.swift
//  JAppical
//
//  Created by Joao Pedro Franco on 05/02/25.
//

import SwiftUI
import JUI

@main
struct JAppicalApp: App {
	init() {
		FontLoader.registerFonts()
	}

	var body: some Scene {
		WindowGroup {
			NavigationView {
				DashboardScreen()
			}
		}
	}
}
