// Created in 2025

import Foundation
import Combine
import JFoundation

public protocol NewHireServiceProtocol {
	func getThisMonth() -> AnyPublisher<[NewHire]?, Never>
	func getAll() -> AnyPublisher<[NewHire]?, Never>
}

public class NewHireService: NewHireServiceProtocol {
	var dataSource: DataSourceProtocol

	public init(dataSource: DataSourceProtocol = RemoteDataSource()) {
		self.dataSource = dataSource
	}
	
	public func getThisMonth() -> AnyPublisher<[NewHire]?, Never> {
		getAll()
			.map { newHires in newHires?.filter { $0.startDate.asDate.isThisMonth } }
			.eraseToAnyPublisher()
			
	}
	
	public func getAll() -> AnyPublisher<[NewHire]?, Never> {
		dataSource.fetch(request: NewHireRequest.fetchAll)
			.replaceError(with: nil)
			.eraseToAnyPublisher()
	}
}


