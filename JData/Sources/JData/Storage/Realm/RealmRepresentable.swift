// Created in 2025

import RealmSwift

public protocol RealmRepresentable {
	associatedtype RealmType: Object
	var primaryKey: String { get }
	
	var asRealm: RealmType { get }
	init(fromRealm realm: RealmType)
}
