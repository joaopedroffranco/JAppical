// Created in 2025

import Combine

public protocol TaskServiceProtocol {
	func get() -> AnyPublisher<[Task]?, Never>
}

public class TaskService: TaskServiceProtocol {
	var dataSource: DataSourceProtocol

	public init(dataSource: DataSourceProtocol = RemoteDataSource()) {
		self.dataSource = dataSource
	}
	
	public func get() -> AnyPublisher<[Task]?, Never> {
		dataSource.fetch(request: TaskRequest.fetch)
			.replaceError(with: nil)
			.eraseToAnyPublisher()
	}
}


