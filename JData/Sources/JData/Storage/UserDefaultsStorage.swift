// Created in 2025

import Foundation

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

