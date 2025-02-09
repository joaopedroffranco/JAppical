//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation

enum NewHireRequest: Requestable {
	case fetchAll

	var method: RequestMethod { .get }
	var host: String { "https://67a5f0ca510789ef0df9d159.mockapi.io" }
	var endpoint: String { "/new_hires" }
	var params: [String : Any]? { nil }
	var headers: [String : String]? { nil }
	var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}
