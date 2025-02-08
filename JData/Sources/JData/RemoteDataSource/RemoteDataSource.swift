//
//  Created by João Pedro Fabiano Franco on 07.09.23.
//

import Foundation
import Combine

public typealias RemotePublisher<T: Decodable> = AnyPublisher<T, Error>

public enum RemoteDataSourceError: Error {
	case invalidRequest
	case decodeError
	case requestFailed
}

public class RemoteDataSource: RemoteDataSourceProtocol {
	let session: URLSession
	let cacheStorage: URLCache.StoragePolicy // TODO: Check if still needed

	public init(session: URLSession = .shared, cacheStorage: URLCache.StoragePolicy = .allowedInMemoryOnly) {
		self.session = session
		self.cacheStorage = cacheStorage
	}
	
	public func fetch<T>(request: Requestable) -> RemotePublisher<T> where T : Decodable {
		guard let request = request.request else {
			return Fail(error: RemoteDataSourceError.invalidRequest).eraseToAnyPublisher()
		}
		
		return session.dataTaskPublisher(for: request)
//			.handleEvents(receiveOutput: { [weak self] data, response in
//				guard let self = self else { return }
//				let cachedResponse = CachedURLResponse(response: response, data: data, storagePolicy: self.cacheStorage)
//				URLCache.shared.storeCachedResponse(cachedResponse, for: request)
//			})
			.map { $0.data }
			.decode(type: T.self, decoder: JSONDecoder())
			.mapError { _ in RemoteDataSourceError.decodeError }
			.eraseToAnyPublisher()
	}
}
