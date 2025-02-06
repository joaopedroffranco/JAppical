//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

/// Defines the app's Design System.
///
/// Instead of using hardcoded values, these resources are referenced to allow easy updates when the brand changes.
///
/// The available resources include `Colors`, `Fonts`, `Radius`, and `Spacings`.
public enum DesignSystem {
  public enum Colors {
		public static let white = Color.white
		public static let dark = Color.black
		public static let gray = Color(red: 107/255, green: 107/255, blue: 107/255)
		public static let darkGray = Color(red: 73/255, green: 74/255, blue: 74/255)
		public static let lightGray = Color(red: 242/255, green: 242/255, blue: 242/255)

		public static let background = white
		public static let primary = Color(red: 0/255, green: 106/255, blue: 255/255)
		public static let shadow = dark.opacity(0.1)
		public static let border = lightGray
		public static let separator = Color(red: 218/255, green: 218/255, blue: 218/255)
  }

  public enum Fonts {
		public static let title = Font.custom("Mulish-Bold", size: 24)
		public static let `default` = Font.custom("Mulish-Regular", size: 14)
		public static let heading = Font.custom("Mulish-Bold", size: 16)
		public static let description = Font.custom("Mulish-Regular", size: 16)
		public static let section = Font.custom("Mulish-Bold", size: 20)
		public static let underSection = Font.custom("Mulish-Medium", size: 16)
		public static let huge = Font.custom("Mulish-Bold", size: 32)
  }

  public enum Radius {
		public static let `default`: CGFloat = 16.0
  }

  public enum Spacings {
		public static let small = 6.0
		public static let margin = 12.0
		public static let large = 22.0
		public static let huge = 24.0
  }
	
	public enum Assets {
		public static var logo = "logo"
		public static var placeholder = "placeholder"
		public static var placeholderAvatar = "placeholder_avatar"
		public static var personIcon = "person_icon"
		public static var header = "header"
	}
}

public extension Color {
	var uiColor: UIColor { UIColor(self) }
}
