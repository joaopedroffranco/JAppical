//
//  Created by João Pedro Fabiano Franco on 07.09.23.
//

import Foundation

public enum RemoteDataSourceError: Error {
	case invalidRequest
	case decodeError
	case requestFailed
}

/// A concrete implementation of the `RemoteDataSourceProtocol` for fetching remote data.
///
/// The `RemoteDataSource` class is responsible for sending network requests using `URLSession` and decoding the response
/// data into a specified `Decodable` type. It handles request creation, error handling, and data decoding.
///
/// This class provides:
/// - A method to fetch and decode data from a remote server based on a `Requestable` object.
/// - Default URLSession configuration with the option to pass a custom session if needed.
///
/// - Throws:
///   - `RemoteDataSourceError.invalidRequest` if the request cannot be created.
///   - `RemoteDataSourceError.decodeError` if decoding fails.
///
/// ```
/// let dataSource = RemoteDataSource()
/// let result: MyModel = try await dataSource.fetch(request: myRequest)
/// ```
public class RemoteDataSource: RemoteDataSourceProtocol {
	let session: URLSession
	
	public init(session: URLSession = .shared) {
		self.session = session
	}
	
	public func fetch<T: Decodable>(request: Requestable) async throws -> T {
		guard let request = request.request else {
			throw RemoteDataSourceError.invalidRequest
		}
		
		do {
			let (data, _) = try await session.data(for: request)
			return try JSONDecoder().decode(T.self, from: data)
		} catch {
			throw RemoteDataSourceError.decodeError
		}
	}
}
