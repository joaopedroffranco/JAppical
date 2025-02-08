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
		public static let green = Color(red: 34/255, green: 129/255, blue: 90/255)
		public static let red = Color(red: 221/255, green: 0/255, blue: 7/255)

		public static let background = white
		public static let primary = Color(red: 0/255, green: 106/255, blue: 255/255)
		public static let shadow = dark.opacity(0.1)
		public static let shadowBorder = lightGray
		public static let border = Color(red: 192/255, green: 192/255, blue: 192/255)
		public static let separator = Color(red: 218/255, green: 218/255, blue: 218/255)
		public static let textfield = Color(red: 242/255, green: 247/255, blue: 255/255)
		public static let textfieldBorder = Color(red: 217/255, green: 232/255, blue: 255/255)
  }

  public enum Fonts {
		public static let title = Font.custom("Mulish-Bold", size: 24)
		public static let `default` = Font.custom("Mulish-Regular", size: 16)
		public static let heading = Font.custom("Mulish-Bold", size: 16)
		public static let description = Font.custom("Mulish-Regular", size: 14)
		public static let textfield = Font.custom("Mulish-Regular", size: 14)
		public static let section = Font.custom("Mulish-Bold", size: 20)
		public static let underSection = Font.custom("Mulish-Medium", size: 16)
		public static let button = Font.custom("Mulish-Medium", size: 16)
		public static let huge = Font.custom("Mulish-Bold", size: 32)
  }

  public enum Radius {
		public static let `default` = 16.0
		public static let small = 8.0
		public static let button = 100.0
		public static let textfield = 4.0
  }

  public enum Spacings {
		public static let small = 4.0
		public static let margin = 16.0
		public static let `default` = 8.0
		public static let largeMargin = 24.0
  }
	
	public enum Assets {
		public static var logoExtended = "logo_extended"
		public static var logo = "logo"
		public static var header = "header"
		public static var placeholder = "placeholder"
		public static var placeholderAvatar = "placeholder_avatar"
		public static var loading = "loading"
		public static var personIcon = "person_icon"
		public static var todoIcon = "todo_icon"
		public static var checkedIcon = "checked_icon"
		public static var calendarIcon = "calendar_icon"
		public static var successIcon = "success_icon"
		public static var sortIcon = "sort_icon"
		public static var eyeIcon = "eye_icon"
		public static var eyeCutIcon = "eye_cut_icon"
	}
}

public extension Color {
	var uiColor: UIColor { UIColor(self) }
}
