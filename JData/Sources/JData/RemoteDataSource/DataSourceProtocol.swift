//
//  Created by João Pedro Fabiano Franco on 07.09.23.
//

import Foundation

/// A protocol that defines the contract for fetching remote data.
///
/// The `RemoteDataSourceProtocol` is designed to handle asynchronous data fetching from a remote source. It provides
/// a method to fetch data and decode it into a specified type that conforms to the `Decodable` protocol.
///
/// This protocol is typically adopted by classes responsible for network communication, such as API clients.
///
/// - Requires:
///   - `Requestable`: A type that encapsulates the details of the request.
///
/// ```
/// class MyRemoteDataSource: RemoteDataSourceProtocol {
///     func fetch<T: Decodable>(request: Requestable) async throws -> T {
///         // Implementation of the fetch logic
///     }
/// }
/// ```
public protocol RemoteDataSourceProtocol: AnyObject {
  func fetch<T: Decodable>(request: Requestable) async throws -> T
}
