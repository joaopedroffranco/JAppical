// Created in 2025

import Combine

public protocol TodoTaskServiceProtocol {
	func get() -> AnyPublisher<[TodoTask]?, Never>
	func check(taskId: String, isChecked: Bool) -> AnyPublisher<TodoTask?, Never>
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
	
	public func check(taskId: String, isChecked: Bool) -> AnyPublisher<TodoTask?, Never> {
		dataSource.fetch(request: TodoTaskRequest.update(id: taskId, isChecked: isChecked))
			.replaceError(with: nil)
			.eraseToAnyPublisher()
	}
}


