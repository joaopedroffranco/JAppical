// Created in 2025

import UIKit

public class FontLoader {
	public static func registerFonts() {
		let fontNames = [
			"Mulish-Regular",
			"Mulish-Bold",
			"Mulish-Light",
			"Mulish-Medium",
		]
		fontNames.forEach { registerFont(named: $0) }
	}
	
	private static func registerFont(named fontName: String) {
		guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: "ttf") else {
			print("❌ Font \(fontName) not found!")
			return
		}
		
		guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
					let font = CGFont(fontDataProvider) else {
			print("❌ Error when loading \(fontName)")
			return
		}
		
		var error: Unmanaged<CFError>?
		if !CTFontManagerRegisterGraphicsFont(font, &error) {
			print("❌ Erro to register \(fontName): \(error.debugDescription)")
		} else {
			print("✅ Font \(fontName) registered!")
		}
	}
}
