import XCTest
import RealmSwift
@testable import JData

final class TodoTaskServiceTests: XCTestCase {
	var cache: FakeRealmStorage { .init() }
	
	override func setUp() {
		cache.reset()
	}
	
	// MARK: - Get
	func testGetRegularResponse() async throws {
		// given
		let service = TodoTaskService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.regularTasks), cacheStorage: cache)
		
		// when
		let tasks = await service.get()

		// then
		XCTAssertEqual(tasks?.count, 3)
	}
	
	func testGetRegularResponseThenSaveOnCache() async throws {
		// given
		let service = TodoTaskService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.regularTasks), cacheStorage: cache)
		
		XCTAssertEqual(cache.getAll(ofType: TodoTask.self)?.count, 0)
		
		// when
		let tasks = await service.get()

		// then
		XCTAssertEqual(tasks?.count, 3)
		XCTAssertEqual(cache.getAll(ofType: TodoTask.self)?.count, 3)
	}

	func testGetRegularResponseFromCache() async throws {
		// given
		let currentCache = cache
		let service = TodoTaskService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.emptyTasks), cacheStorage: currentCache)

		currentCache.save(TodoTaskStubs.instance)

		// when
		let tasks = await service.get()

		// then
		XCTAssertEqual(tasks?.count, 1)
	}

	func testGetIrregularResponse() async throws {
		// given
		let service = TodoTaskService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.irregularTasks), cacheStorage: cache)

		// when
		let tasks = await service.get()

		// then
		XCTAssertNil(tasks)
	}

	func testGetEmptyResponse() async throws {
		// given
		let service = TodoTaskService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.emptyNewHires), cacheStorage: cache)

		// when
		let allNewHires = await service.get()

		// then
		XCTAssertNil(allNewHires)
	}
	
	// MARK: - Check
	func testCheckWithRemote() async throws {
		// given
		let currentCache = cache
		let dataSource = FakeRemoteDataSource(jsonFile: JSONFile.regularTasks)
		let service = TodoTaskService(dataSource: dataSource, cacheStorage: currentCache)
		
		currentCache.save(TodoTaskStubs.manyNotDone)
		
		// when
		service.check(true, taskId: "1")

		// then
		guard let cachedTasks = currentCache.getAll(ofType: TodoTask.self), let first = cachedTasks.first else { return XCTFail() }
		XCTAssertTrue(first.isDone)
	}
	
	func testCheckWithNoRemote() async throws {
		// given
		let currentCache = cache
		let dataSource = FakeRemoteDataSource(jsonFile: JSONFile.regularTasks)
		let service = TodoTaskService(dataSource: dataSource, cacheStorage: currentCache)
		
		currentCache.save(TodoTaskStubs.manyNotDone)
		let expectation = expectation(description: "Fetching...")
		var didSaveCount = 0
		currentCache.didSave = {
			if didSaveCount == 1 { expectation.fulfill() } else { didSaveCount += 1 }
		}
		
		// when
		service.check(true, taskId: "1")
		await waitForExpectations(timeout: 1)
		
		// then
		guard let cachedTasks = currentCache.getAll(ofType: TodoTask.self), let first = cachedTasks.first else { return XCTFail() }
		XCTAssertTrue(first.isDone)
		XCTAssertFalse(first.isRemoteUpdated)
	}
	
	// MARK: - Sync Remote
	func testSyncRemote() async throws {
		// given
		let currentCache = cache
		let dataSource = FakeRemoteDataSource(jsonFile: JSONFile.regularTask) // Id 2 is the one synced.
		let service = TodoTaskService(dataSource: dataSource, cacheStorage: currentCache)

		currentCache.save(TodoTaskStubs.manyNotRemoteUpdated)
		let expectation = expectation(description: "Syncing...")
		var didSaveCount = 0
		let numberOfNotUpdated = 1 // Only Id 2
		currentCache.didSave = {
			if didSaveCount == numberOfNotUpdated - 1 { expectation.fulfill() } else { didSaveCount += 1 }
		}
		
		// when
		await service.syncRemote()
		await waitForExpectations(timeout: 1)
		
		// then
		guard let cachedTasks = currentCache.getAll(ofType: TodoTask.self) else { return XCTFail() }
		XCTAssertNil(cachedTasks.first { !$0.isRemoteUpdated } )
	}
}
