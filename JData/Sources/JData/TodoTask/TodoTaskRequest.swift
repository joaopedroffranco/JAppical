//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation

enum TodoTaskRequest: Requestable {
	case fetch
	case update(id: String, isChecked: Bool)

	var method: RequestMethod {
		switch self {
		case .fetch: return .get
		case .update: return .put
		}
	}

	var endpoint: String {
		switch self {
		case .fetch: return "/tasks"
		case let .update(id, _): return "/tasks/\(id)"
		}
	}
	
	var params: [String : Any]? {
		switch self {
		case .fetch: return nil
		case let .update(_, isChecked): return ["isDone": isChecked]
		}
	}
	
	var host: String { "https://67a5f0ca510789ef0df9d159.mockapi.io" }
	var headers: [String : String]? { nil }
	var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}
