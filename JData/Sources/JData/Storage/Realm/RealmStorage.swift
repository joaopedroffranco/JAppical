// Created in 2025

import Foundation
import RealmSwift

/// A concrete implementation of the `RealmStorageProtocol` for managing data in Realm database.
///
/// The `RealmStorage` class handles saving, retrieving, and deleting objects in the Realm database. It works with objects
/// that conform to the `RealmRepresentable` protocol to map between the model and Realm objects.
///
/// This class provides:
/// - Methods for saving a single object or an array of objects to the database.
/// - Methods for fetching an object by its primary key or retrieving all objects of a specific type.
/// - A method to clean (delete) all objects of a specified type.
///
/// - Returns:
///   - `nil` if an error occurs during Realm operations or if the instance cannot be created.
///
/// ```
/// let storage = RealmStorage()
/// storage.save(someObject)
/// let result: MyModel? = storage.get(ofType: MyModel.self, primaryKey: "someID")
/// storage.clean(ofType: MyModel.self)
/// ```
public class RealmStorage: RealmStorageProtocol {
	public init() {}
	
	var instance: Realm? {
		do { return try Realm() } catch { return nil }
	}
	
	public func save<T: RealmRepresentable>(_ object: T) {
		guard let instance = instance else { return }
		
		let realmObject = object.asRealm
		do {
			try instance.write { instance.add(realmObject, update: .modified) }
		} catch {
			return
		}
	}
	
	public func save<T: RealmRepresentable>(_ objects: [T]) {
		guard let instance = instance else { return }
		
		let realmObjects = objects.map { $0.asRealm }
		do {
			try instance.write { instance.add(realmObjects, update: .modified) }
		} catch {
			return
		}
	}
	
	public func get<T: RealmRepresentable>(ofType type: T.Type, primaryKey: String) -> T? {
		guard let instance = instance else { return nil }
		
		guard let realmObject = instance.object(ofType: T.RealmType.self, forPrimaryKey: primaryKey) else { return nil }
		return T(fromRealm: realmObject)
	}

	public func getAll<T: RealmRepresentable>(ofType type: T.Type) -> [T]? {
		guard let instance = instance else { return nil }
		
		let realmObjects = instance.objects(T.RealmType.self)
		return realmObjects.map { T(fromRealm: $0) }
	}
	
	public func clean<T>(ofType type: T.Type) where T : RealmRepresentable {
		guard let instance = instance else { return }
		
		let realmObjects = instance.objects(T.RealmType.self)
		do {
			try instance.write { instance.delete(realmObjects) }
		} catch {
			return
		}
	}
}
