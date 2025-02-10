//
//  Created in 2025
//

import UIKit
@testable import JData

public class FakeRemoteDataSource: RemoteDataSource {
	let jsonFile: JSONFileProtocol
	
	init(jsonFile: JSONFileProtocol) {
		self.jsonFile = jsonFile
	}
	
	public override func fetch<T: Decodable>(request: Requestable) async throws -> T {
		guard
			let data = get(file: self.jsonFile),
			let response = try? JSONDecoder().decode(T.self, from: data)
		else {
			throw NSError()
		}

		return response
	}

	private func get(file: JSONFileProtocol) -> Data? {
		guard let url = Bundle.module.url(
			forResource: file.name,
			withExtension: "json"
		) else {
			return nil
		}

		do {
			let data = try Data(contentsOf: url)
			return data
		} catch {
			return nil
		}
	}
}
