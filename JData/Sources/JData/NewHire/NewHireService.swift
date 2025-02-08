// Created in 2025

import Combine

public protocol NewHireServiceProtocol {
	func getAll() -> AnyPublisher<[NewHire]?, Never>
}

public class NewHireService: NewHireServiceProtocol {
	var dataSource: DataSourceProtocol

	public init(dataSource: DataSourceProtocol = RemoteDataSource()) {
		self.dataSource = dataSource
	}
	
	public func getAll() -> AnyPublisher<[NewHire]?, Never> {
		dataSource.fetch(request: NewHireRequest.fetchAll)
			.replaceError(with: nil)
			.eraseToAnyPublisher()
	}
}


