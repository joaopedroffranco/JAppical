// Created in 2025

import UIKit

public class NavigationBarAppearance {
	public static func setup() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = DesignSystem.Colors.primary.uiColor
		appearance.titleTextAttributes = [.foregroundColor: DesignSystem.Colors.white.uiColor]
		appearance.largeTitleTextAttributes = [.foregroundColor: DesignSystem.Colors.white.uiColor]
		
		UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().scrollEdgeAppearance = appearance
		UINavigationBar.appearance().tintColor = DesignSystem.Colors.white.uiColor
	}
}
