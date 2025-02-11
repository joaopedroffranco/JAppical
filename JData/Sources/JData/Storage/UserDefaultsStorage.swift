// Created in 2025

import Foundation

/// A concrete implementation of the `StorageProtocol` using `UserDefaults` for storage.
///
/// The `UserDefaultsStorage` class provides a simple way to save, retrieve, and remove `Codable` values from `UserDefaults`.
/// It uses `JSONEncoder` and `JSONDecoder` to encode and decode values, enabling the storage of complex types in the defaults.
///
/// This class provides:
/// - A method to save a `Codable` value to `UserDefaults` under a specific key.
/// - A method to retrieve a `Codable` value from `UserDefaults` using the key.
/// - A method to remove a value from `UserDefaults` based on the key.
///
/// ```
/// let storage = UserDefaultsStorage()
/// storage.set(user, forKey: "userKey")
/// let retrievedUser: User? = storage.get(forKey: "userKey")
/// storage.remove(forKey: "userKey")
/// ```
public class UserDefaultsStorage: StorageProtocol {
	private let defaults: UserDefaults
	
	public init(defaults: UserDefaults = .standard) {
		self.defaults = defaults
	}
	
	public func set<T: Codable>(_ value: T, forKey key: String) {
		if let encoded = try? JSONEncoder().encode(value) {
			defaults.set(encoded, forKey: key)
		}
	}
	
	public func get<T: Codable>(forKey key: String) -> T? {
		guard let data = defaults.data(forKey: key),
					let decoded = try? JSONDecoder().decode(T.self, from: data) else { return nil }
		return decoded
	}
	
	public func remove(forKey key: String) {
		defaults.removeObject(forKey: key)
	}
}

