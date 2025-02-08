// Created in 2025

import Foundation

public enum Credentials {
	public static let expectedEmail = "email@gmail.com"
	public static let expectedPassword = "password1234"
	public static let expectedEmailKey = "email"
	public static let expectedPasswordKey = "password"
	public static let loggedUserKey = "logged_user"
	
	public static let loggedUser = User(
		id: "1", name: "João Pedro", avatar: "https://loremflickr.com/50/50"
	)
}
