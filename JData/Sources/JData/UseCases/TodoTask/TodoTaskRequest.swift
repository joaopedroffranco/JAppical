// Created in 2025

import Foundation

enum TodoTaskRequest: Requestable {
	case fetch
	case markAsDone(id: String, isDone: Bool)
	case update(id: String, task: TodoTask)

	var method: RequestMethod {
		switch self {
		case .fetch: return .get
		case .update, .markAsDone: return .put
		}
	}

	var endpoint: String {
		switch self {
		case .fetch: return "/tasks"
		case let .markAsDone(id, _), let .update(id, _): return "/tasks/\(id)"
		}
	}
	
	var params: [String : Any]? {
		switch self {
		case .fetch: return nil
		case let .markAsDone(_, isDone): return ["isDone": isDone]
		case let .update(_, task):
			do {
				return try JSONSerialization.jsonObject(with: try JSONEncoder().encode(task)) as? [String: Any]
			} catch {
				return nil
			}
		}
	}
	
	var host: String { "https://67a5f0ca510789ef0df9d159.mockapi.io" }
	var headers: [String : String]? { nil }
	var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}
