// Created in 2025

import Foundation

public protocol RealmStorageProtocol {
	func save<T: RealmRepresentable>(_ object: T)
	func getAll<T: RealmRepresentable>(ofType type: T.Type) -> [T]?
}
