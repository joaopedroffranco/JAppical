// Created in 2025

import Foundation

public enum Strings {
	public static var home = "Appical"
	public static var newsHires = "Recently assigned new hires"
	public static var today = "Today"
	public static var tomorrow = "Tomorrow"
	public static func dueDate(_ date: String) -> String { "Due \(date)" }
	
	public enum Login {
		public static var title = "Log in"
		public static var loginIn = "Log in"
		public static var next = "Next"
		public static var email = "Email"
		public static var password = "Password"
	}
	
	public enum Dashboard {
		public static var newHireJourneyTitle = "Your new hires journey to success!"
		public static var newHireJourneyDescription = "As a manager responsible for onboarding new hires, your role is pivotal in guiding them towards success. By providing clear and comprehensive training, you lay a solid foundation for their professional growth,"

		public static var recentlyHires = "Recently assigned new hires"
		public static var recentlyHiresStartDate = "New hires started this month"
		public static var recentlyHiresAction = "Send them a message to make them feel welcome"
		
		public static var todo = "To do’s due soon"
		public static var todoCompleted = "Nice work!\nYou’ve completed all you to do’s"
		
		public enum Sections {
			public static var todos = "To do's"
			public static var newHires = "New hires"
		}
	}
	
	public enum NewHires {
		public static var title = "Welcome your new hires"
		public static var sendMessage = "Send welcome message"
		
		public static var sortEarliest = "Earliest Start Date First"
		public static var sortLatest = "Latest Start Date First"
		
		public static func firstDay(_ first: String) -> String { "First Day \(first)" }
	}
}
