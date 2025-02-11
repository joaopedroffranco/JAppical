// Created in 2025

import Foundation
import JFoundation

public protocol NewHireServiceProtocol {
	func getThisMonth() async -> [NewHire]?
	func getAll() async -> [NewHire]?
}

/// A service for managing new hires, which fetches new hire data either from a remote source or local cache, and provides
/// the data to the consumer while ensuring synchronization between the cache and remote data.
///
/// The `NewHireService` class is responsible for fetching new hire information. It checks for the availability of data
/// in a local cache (using `RealmStorageProtocol`), and if not found, it fetches the data from a remote source
/// (using `RemoteDataSourceProtocol`). The data is then cached for future access. The service includes methods to fetch
/// new hires for the current month and to fetch all new hires.
///
/// This class provides:
/// - A method to fetch new hires for the current month, checking both the cache and remote source.
/// - A method to fetch all new hires, again checking both the cache and remote source.
/// - Caching logic to store data retrieved from the remote source for future use.
///
/// **Note**: The cache is updated whenever new data is fetched from the remote source.
///
/// ```
/// let newHireService = NewHireService()
/// let thisMonthNewHires = await newHireService.getThisMonth()
/// let allNewHires = await newHireService.getAll()
/// ```
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
