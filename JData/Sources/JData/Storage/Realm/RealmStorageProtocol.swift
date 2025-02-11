// Created in 2025

import Foundation

/// A protocol defining methods for interacting with Realm database.
///
/// The `RealmStorageProtocol` provides a set of methods for saving, retrieving, and cleaning objects in Realm. It is
/// intended to be adopted by classes responsible for managing data persistence using the Realm database framework.
///
/// The protocol includes:
/// - Methods for saving a single object or an array of objects that conform to the `RealmRepresentable` protocol.
/// - Methods for retrieving objects by primary key or getting all objects of a specific type.
/// - A method to clean (delete) all objects of a specific type.
///
/// ```
/// class MyRealmStorage: RealmStorageProtocol {
///     func save<T: RealmRepresentable>(_ object: T) {
///         // Implementation to save object
///     }
/// }
/// ```
public protocol RealmStorageProtocol {
	func save<T: RealmRepresentable>(_ object: T)
	func save<T: RealmRepresentable>(_ objects: [T])
	func get<T: RealmRepresentable>(ofType type: T.Type, primaryKey: String) -> T?
	func getAll<T: RealmRepresentable>(ofType type: T.Type) -> [T]?
	func clean<T: RealmRepresentable>(ofType type: T.Type)
}
