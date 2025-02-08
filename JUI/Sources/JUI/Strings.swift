// Created in 2025

import Foundation

public enum Strings {
	public static let home = "Appical"
	public static let newsHires = "Recently assigned new hires"
	public static let today = "Today"
	public static let tomorrow = "Tomorrow"
	public static func dueDate(_ date: String) -> String { "Due \(date)" }
	
	public enum Login {
		public static let title = "Log in"
		public static let loginIn = "Log in"
		public static let next = "Next"
		public static let email = "Email"
		public static let password = "Password"
		
		public enum Errors {
			public static let emailNotExist = "This email doesn't exist on our system."
			public static let emailInvalid = "This is not a valid email."
			public static let wrongPassword = "Password is wrong."
		}
	}
	
	public enum Dashboard {
		public static let newHireJourneyTitle = "Your new hires journey to success!"
		public static let newHireJourneyDescription = "As a manager responsible for onboarding new hires, your role is pivotal in guiding them towards success. By providing clear and comprehensive training, you lay a solid foundation for their professional growth,"

		public static let recentlyHires = "Recently assigned new hires"
		public static let recentlyHiresStartDate = "New hires started this month"
		public static let recentlyHiresAction = "Send them a message to make them feel welcome"
		
		public static let todo = "To do’s due soon"
		public static let todoCompleted = "Nice work!\nYou’ve completed all you to do’s"
		
		public static func welcomeBack(_ name: String) -> String { "Welcome back, \(name)!" }
		
		public enum Sections {
			public static let todos = "To do's"
			public static let newHires = "New hires"
		}
	}
	
	public enum NewHires {
		public static let title = "Welcome your new hires"
		public static let sendMessage = "Send welcome message"
		
		public static let sortEarliest = "Earliest Start Date First"
		public static let sortLatest = "Latest Start Date First"
		
		public static func firstDay(_ first: String) -> String { "First Day \(first)" }
	}
}
