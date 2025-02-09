// Created in 2025

import Foundation
import RealmSwift

public struct TodoTask {
	public let id: String
	public let text: String
	public let dueDate: TimeInterval
	public let isDone: Bool
	
	public init(
		id: String,
		text: String,
		dueDate: TimeInterval,
		isDone: Bool
	) {
		self.id = id
		self.text = text
		self.dueDate = dueDate
		self.isDone = isDone
	}
}

extension TodoTask: Codable {}

// MARK: - Realm
public class TodoTaskRealm: Object {
	@Persisted var id: String = ""
	@Persisted var text: String = ""
	@Persisted var dueDate: TimeInterval = 0
	@Persisted var isDone: Bool = false
}

extension TodoTask: RealmRepresentable {
	public var asRealm: TodoTaskRealm {
		let object = TodoTaskRealm()
		object.id = id
		object.text = text
		object.dueDate = dueDate
		object.isDone = isDone
		return object
	}
	
	public init(fromRealm realm: TodoTaskRealm) {
		self.id = realm.id
		self.text = realm.text
		self.dueDate = realm.dueDate
		self.isDone = realm.isDone
	}
}
