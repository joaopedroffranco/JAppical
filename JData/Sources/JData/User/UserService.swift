//
//  Created by Joao Pedro Franco on 15/07/24.
//

import Combine

public protocol UserServiceProtocol {
	func checkEmail(email: String) -> AnyPublisher<Bool, Never>
	func authenticate(email: String, password: String) -> AnyPublisher<Bool, Never>
}

public class UserService: UserServiceProtocol {
	var dataSource: DataSourceProtocol

	public init(dataSource: DataSourceProtocol = RemoteDataSource()) {
		self.dataSource = dataSource
	}
	
	public func checkEmail(email: String) -> AnyPublisher<Bool, Never> {
		Just(true)
			.eraseToAnyPublisher()
		
		// TODO: Call UserDefaults
	}
	
	public func authenticate(email: String, password: String) -> AnyPublisher<Bool, Never> {
		Just(true)
			.eraseToAnyPublisher()
		
		// TODO: Call UserDefaults
	}
}
