// Created in 2025

import Foundation

public protocol TodoTaskServiceProtocol {
	func get() async -> [TodoTask]?
	func markAsDone(_ isDone: Bool, taskId: String)
}

/// A service for managing to-do tasks, providing functionality to fetch tasks from a remote source or cache,
/// as well as updating their completion status (done/undone).
///
/// The `TodoTaskService` class is responsible for retrieving and managing to-do task data.
/// First, it synchronizes the local cache with the remote data source. After that, it fetches tasks from the remote source
/// and then from the local cache if necessary. This service also supports marking tasks as done or undone, saving the
/// updated status to both the cache and remote source.
///
/// This class provides:
/// - A method to fetch all to-do tasks, checking the remote source first, then falling back to the cache if remote data is unavailable.
/// - A method to mark a task as done or undone, updating both the cache and remote source.
/// - Synchronization logic to push local changes to the remote source.
/// - Caching logic to store tasks for future use.
///
/// **Note**: The tasks are synchronized between the cache and the remote source to ensure consistency.
/// If a task's completion status changes, both the cache and remote data are updated.
///
/// ```
/// let todoTaskService = TodoTaskService()
/// let tasks = await todoTaskService.get() // Fetch tasks
/// todoTaskService.markAsDone(true, taskId: "task123") // Mark task as done
/// ```
public class TodoTaskService: TodoTaskServiceProtocol {
	private let dataSource: RemoteDataSourceProtocol
	private let cacheStorage: RealmStorageProtocol
	
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
		} else if let cachedTasks = fetchFromCache(), !cachedTasks.isEmpty {
			return cachedTasks
		}
		
		return nil
	}
	
	public func markAsDone(_ isDone: Bool, taskId: String) {
		saveDoneOnCache(taskId: taskId, isDone: isDone)
		trySaveDoneOnRemote(taskId: taskId, isDone: isDone)
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
	
	func saveDoneOnCache(taskId: String, isDone: Bool) {
		if var cached = cacheStorage.get(ofType: TodoTask.self, primaryKey: taskId) {
			cached.isDone = isDone
			cacheStorage.save(cached)
		}
	}
	
	func trySaveDoneOnRemote(taskId: String, isDone: Bool) {
		Task {
			guard let _: TodoTask = try? await dataSource.fetch(request: TodoTaskRequest.markAsDone(id: taskId, isDone: isDone)) else {
				if var cached = cacheStorage.get(ofType: TodoTask.self, primaryKey: taskId) {
					cached.isRemoteUpdated = false
					cacheStorage.save(cached)
				}
				return
			}
		}
	}
}
