// Created in 2025

import Foundation

public protocol RealmStorageProtocol {
	func save<T: RealmRepresentable>(_ object: T)
	func save<T: RealmRepresentable>(_ objects: [T])
	func get<T: RealmRepresentable>(ofType type: T.Type, primaryKey: String) -> T?
	func getAll<T: RealmRepresentable>(ofType type: T.Type) -> [T]?
	func clean<T: RealmRepresentable>(ofType type: T.Type)
}
