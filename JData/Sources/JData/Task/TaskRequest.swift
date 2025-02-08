//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation

enum TaskRequest: Requestable {
	case fetch

	var method: RequestMethod { .get }
	var host: String { "https://67a5f0ca510789ef0df9d159.mockapi.io" }
	var endpoint: String { "/tasks" }
	var params: [String : String]? { nil }
	var headers: [String : String]? { nil }
	var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}
