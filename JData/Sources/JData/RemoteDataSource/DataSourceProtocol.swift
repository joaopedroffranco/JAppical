//
//  Created by João Pedro Fabiano Franco on 07.09.23.
//

import Foundation

public protocol RemoteDataSourceProtocol: AnyObject {
  func fetch<T: Decodable>(request: Requestable) async throws -> T
}
