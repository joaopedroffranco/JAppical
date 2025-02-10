// Created in 2025

import Foundation
import RealmSwift

public struct TodoTask: Equatable {
	public let id: String
	public let text: String
	public let dueDate: TimeInterval
	public var isDone: Bool
	var isRemoteUpdated: Bool = true
	
	enum CodingKeys: String, CodingKey {
		case id, text, dueDate, isDone
	}
	
	public init(
		id: String,
		text: String,
		dueDate: TimeInterval,
		isDone: Bool,
		isRemoteUpdated: Bool = true
	) {
		self.id = id
		self.text = text
		self.dueDate = dueDate
		self.isDone = isDone
		self.isRemoteUpdated = isRemoteUpdated
	}
}

extension TodoTask: Codable {}

// MARK: - Realm
public class TodoTaskRealm: Object {
	@Persisted(primaryKey: true) var id: String = ""
	@Persisted var text: String = ""
	@Persisted var dueDate: TimeInterval = 0
	@Persisted var isDone: Bool = false
	@Persisted var isRemoteUpdated: Bool = true
}

extension TodoTask: RealmRepresentable {
	public var primaryKey: String { id }
	
	public var asRealm: TodoTaskRealm {
		let object = TodoTaskRealm()
		object.id = id
		object.text = text
		object.dueDate = dueDate
		object.isDone = isDone
		object.isRemoteUpdated = isRemoteUpdated
		return object
	}
	
	public init(fromRealm realm: TodoTaskRealm) {
		self.id = realm.id
		self.text = realm.text
		self.dueDate = realm.dueDate
		self.isDone = realm.isDone
		self.isRemoteUpdated = realm.isRemoteUpdated
	}
}
