// Created in 2025

import Foundation
import JFoundation

public protocol NewHireServiceProtocol {
	func getThisMonth() async -> [NewHire]?
	func getAll() async -> [NewHire]?
}

public class NewHireService: NewHireServiceProtocol {
	private let dataSource: RemoteDataSourceProtocol
	private let cacheStorage: RealmStorageProtocol
	
	public init(
		dataSource: RemoteDataSourceProtocol = RemoteDataSource(),
		cacheStorage: RealmStorageProtocol = RealmStorage()
	) {
		self.dataSource = dataSource
		self.cacheStorage = cacheStorage
	}
	
	public func getThisMonth() async -> [NewHire]? {
		var newHires: [NewHire]? = nil
		if let remotedHires = await fetchFromRemote(), !remotedHires.isEmpty {
			cacheStorage.save(remotedHires)
			newHires = remotedHires
		} else if let cachedHires = fetchFromCache(), !cachedHires.isEmpty{
			newHires = cachedHires
		}
		
		return newHires?.filter { $0.startDate.asDate.isThisMonth }
	}
	
	public func getAll() async -> [NewHire]? {
		if let cachedHires = fetchFromCache(), !cachedHires.isEmpty {
			return cachedHires
		} else if let remotedHires = await fetchFromRemote(), !remotedHires.isEmpty {
			saveOnCache(remotedHires)
			return remotedHires
		}
		
		return nil
	}
}

private extension NewHireService {
	func fetchFromCache() -> [NewHire]? {
		cacheStorage.getAll(ofType: NewHire.self)
	}
	
	func fetchFromRemote() async -> [NewHire]? {
		let newHires: [NewHire]? = try? await dataSource.fetch(request: NewHireRequest.fetchAll)
		return newHires?.sorted { $0.startDate < $1.startDate }
	}
	
	func saveOnCache(_ newHires: [NewHire]) {
		cacheStorage.clean(ofType: NewHire.self)
		cacheStorage.save(newHires)
	}
}
