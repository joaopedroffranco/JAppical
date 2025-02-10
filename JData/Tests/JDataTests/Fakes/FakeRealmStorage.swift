// Created in 2025

import Foundation
@testable import JData
import RealmSwift

public class FakeRealmStorage: RealmStorage {
	var didSave: (() -> Void)?
	
	public override var instance: Realm? {
		var configuration = Realm.Configuration()
		configuration.fileURL = configuration.fileURL!.deletingLastPathComponent().appendingPathComponent("fake.realm")
		return try? Realm(configuration: configuration)
	}
	
	public override func save<T: RealmRepresentable>(_ object: T) {
		super.save(object)
		didSave?()
	}
	
	public func reset() {
		try? instance?.write { instance?.deleteAll() }
	}
	
	deinit {
		guard let configuration = instance?.configuration else { return }
		_ = try? Realm.deleteFiles(for: configuration)
	}
}
