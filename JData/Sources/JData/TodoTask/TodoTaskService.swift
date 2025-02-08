// Created in 2025

import Combine

public protocol TodoTaskServiceProtocol {
	func get() -> AnyPublisher<[TodoTask]?, Never>
}

public class TodoTaskService: TodoTaskServiceProtocol {
	private let dataSource: RemoteDataSourceProtocol

	public init(dataSource: RemoteDataSourceProtocol = RemoteDataSource()) {
		self.dataSource = dataSource
	}
	
	public func get() -> AnyPublisher<[TodoTask]?, Never> {
		dataSource.fetch(request: TodoTaskRequest.fetch)
			.replaceError(with: nil)
			.eraseToAnyPublisher()
	}
}


