// Created in 2025

import SwiftUI
import JUI

struct DashboardScreen: View {
	var body: some View {
		DashboardView()
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle(Strings.appName)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) { Avatar() }
			}
	}
}
