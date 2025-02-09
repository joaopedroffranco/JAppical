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
			try instance.write { instance.add(realmObject) }
		} catch {
			print("Can't write into Realm")
		}
	}

	public func getAll<T: RealmRepresentable>(ofType type: T.Type) -> [T]? {
		guard let instance = instance else { return nil }
		
		let realmObjects = instance.objects(T.RealmType.self)
		
		return realmObjects.map { T(fromRealm: $0) } 
	}
}
