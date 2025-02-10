// Created in 2025

import Combine

public protocol TodoTaskServiceProtocol {
	func get() async -> [TodoTask]?
	func check(_ isChecked: Bool, taskId: String)
}

public class TodoTaskService: TodoTaskServiceProtocol {
	private let dataSource: RemoteDataSourceProtocol
	private let cacheStorage: RealmStorageProtocol
	
	private var cancellables: Set<AnyCancellable> = []
	
	public init(
		dataSource: RemoteDataSourceProtocol = RemoteDataSource(),
		cacheStorage: RealmStorageProtocol = RealmStorage()
	) {
		self.dataSource = dataSource
		self.cacheStorage = cacheStorage
	}
	
	public func get() async -> [TodoTask]? {
		await syncRemote()
		
		if let remotedTasks = await fetchFromRemote(), !remotedTasks.isEmpty {
			saveOnCache(remotedTasks)
			return remotedTasks
		} else {
			return fetchFromCache()
		}
	}
	
	public func check(_ isChecked: Bool, taskId: String) {
		saveCheckOnCache(taskId: taskId, isChecked: isChecked)
		trySaveCheckOnRemote(taskId: taskId, isChecked: isChecked)
	}
}

private extension TodoTaskService {
	func fetchFromCache() -> [TodoTask]? {
		cacheStorage.getAll(ofType: TodoTask.self)
	}
	
	func fetchFromRemote() async -> [TodoTask]? {
		try? await dataSource.fetch(request: TodoTaskRequest.fetch)
	}
	
	func saveOnCache(_ tasks: [TodoTask]) {
		cacheStorage.clean(ofType: TodoTask.self)
		cacheStorage.save(tasks)
	}
	
	func saveCheckOnCache(taskId: String, isChecked: Bool) {
		if var cached = cacheStorage.get(ofType: TodoTask.self, primaryKey: taskId) {
			cached.isDone = isChecked
			cacheStorage.save(cached)
		}
	}
	
	func trySaveCheckOnRemote(taskId: String, isChecked: Bool) {
		Task {
			guard let _: TodoTask = try? await dataSource.fetch(request: TodoTaskRequest.check(id: taskId, isChecked: isChecked)) else {
				if var cached = cacheStorage.get(ofType: TodoTask.self, primaryKey: taskId) {
					cached.isRemoteUpdated = false
					cacheStorage.save(cached)
				}
				return
			}
		}
	}
	
	func syncRemote() async {
		if let tasks = cacheStorage.getAll(ofType: TodoTask.self)?.filter({ !$0.isRemoteUpdated }) {
			for task in tasks {
				if var updatedTask: TodoTask = try? await dataSource.fetch(request: TodoTaskRequest.update(id: task.id, task: task)) {
					updatedTask.isRemoteUpdated = true
					cacheStorage.save(updatedTask)
				}
			}
		}
	}
}
