import XCTest
import RealmSwift
@testable import JData

final class NewHireServiceTests: XCTestCase {
	var cache: FakeRealmStorage { .init() }
	
	override func setUp() {
		cache.reset()
	}
	
	func testGetAllRegularResponse() async throws {
		// given
		let service = NewHireService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.regularNewHires), cacheStorage: cache)
		
		// when
		let allNewHires = await service.getAll()

		// then
		XCTAssertEqual(allNewHires?.count, 6)
	}
	
	func testGetAllRegularResponseThenSaveOnCache() async throws {
		// given
		let currentCache = cache
		let service = NewHireService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.regularNewHires), cacheStorage: currentCache)
		
		XCTAssertEqual(currentCache.getAll(ofType: NewHire.self)?.count, 0)
		
		// when
		let allNewHires = await service.getAll()

		// then
		XCTAssertEqual(allNewHires?.count, 6)
		XCTAssertEqual(currentCache.getAll(ofType: NewHire.self)?.count, 6)
	}
	
	func testGetAllRegularResponseFromCache() async throws {
		// given
		let currentCache = cache
		let service = NewHireService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.emptyNewHires), cacheStorage: currentCache)
		
		currentCache.save(NewHireStubs.instance)
		
		// when
		let allNewHires = await service.getAll()

		// then
		XCTAssertEqual(allNewHires?.count, 1)
	}
	
	func testGetAllIrregularResponse() async throws {
		// given
		let service = NewHireService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.irregularNewHires), cacheStorage: cache)
		
		// when
		let allNewHires = await service.getAll()

		// then
		XCTAssertNil(allNewHires)
	}
	
	func testGetAllEmptyResponse() async throws {
		// given
		let service = NewHireService(dataSource: FakeRemoteDataSource(jsonFile: JSONFile.emptyNewHires), cacheStorage: cache)
		
		// when
		let allNewHires = await service.getAll()

		// then
		XCTAssertNil(allNewHires)
	}
}
