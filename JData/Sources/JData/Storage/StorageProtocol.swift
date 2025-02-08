// Created in 2025

import Foundation

public protocol StorageProtocol {
	func set<T: Codable>(_ value: T, forKey key: String)
	func get<T: Codable>(forKey key: String) -> T?
	func remove(forKey key: String)
}

