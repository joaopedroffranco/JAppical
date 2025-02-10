// Created in 2025

import Foundation
import RealmSwift

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
	
	public func save<T>(_ objects: [T]) where T : RealmRepresentable {
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
