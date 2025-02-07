//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation

enum NewHiresRequest: Requestable {
	case fetch

	var method: RequestMethod { .get }
	var host: String { "https://67a5f0ca510789ef0df9d159.mockapi.io" }
	var endpoint: String { "/new_hires" }
	var params: [String : String]? { nil }
	var headers: [String : String]? { nil }
	var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}
