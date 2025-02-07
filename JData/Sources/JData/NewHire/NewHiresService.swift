// Created in 2025

import Combine

public protocol NewHiresServiceProtocol {
	func get() -> AnyPublisher<[NewHire], Error>
}

public class NewHiresService: NewHiresServiceProtocol {
	var dataSource: DataSourceProtocol

	public init(dataSource: DataSourceProtocol = RemoteDataSource()) {
		self.dataSource = dataSource
	}
	
	public func get() -> AnyPublisher<[NewHire], Error> {
		dataSource.fetch(request: NewHiresRequest.fetch)
			.eraseToAnyPublisher()
	}
}


