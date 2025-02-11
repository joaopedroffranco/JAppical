// Created in 2025

import Foundation

/// A protocol defining methods for storing and retrieving Codable values.
///
/// The `StorageProtocol` provides methods to save, retrieve, and remove values from a storage system. The values are
/// required to conform to the `Codable` protocol to allow for encoding and decoding, making it suitable for persistent
/// storage systems such as UserDefaults, file storage, or custom storage solutions.
///
/// This protocol includes:
/// - A method to save a `Codable` value under a specific key.
/// - A method to retrieve a `Codable` value by its key.
/// - A method to remove a value for a specific key.
///
/// ```
/// class MyStorage: StorageProtocol {
///     func set<T: Codable>(_ value: T, forKey key: String) {
///         // Save value logic
///     }
/// }
/// ```
public protocol StorageProtocol {
	func set<T: Codable>(_ value: T, forKey key: String)
	func get<T: Codable>(forKey key: String) -> T?
	func remove(forKey key: String)
}
