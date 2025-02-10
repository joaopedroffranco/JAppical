// Created in 2025

import Foundation
import RealmSwift

public struct NewHire {
	public let id: String
	public let name: String
	public let startDate: TimeInterval
	public let avatar: String?
	
	public init(
		id: String,
		name: String,
		startDate: TimeInterval,
		avatar: String?
	) {
		self.id = id
		self.name = name
		self.startDate = startDate
		self.avatar = avatar
	}
}

extension NewHire: Decodable {}

// MARK: - Realm
public class NewHireRealm: Object {
	@Persisted(primaryKey: true) var id: String = ""
	@Persisted var name: String = ""
	@Persisted var startDate: TimeInterval = 0
	@Persisted var avatar: String?
}

extension NewHire: RealmRepresentable {
	public var primaryKey: String { id }
	
	public var asRealm: NewHireRealm {
		let object = NewHireRealm()
		object.id = id
		object.name = name
		object.startDate = startDate
		object.avatar = avatar
		return object
	}
	
	public init(fromRealm realm: NewHireRealm) {
		self.id = realm.id
		self.name = realm.name
		self.startDate = realm.startDate
		self.avatar = realm.avatar
	}
}
