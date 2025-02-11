// Created in 2025

import RealmSwift

/// A protocol that represents a model that can be mapped to and from a Realm object.
///
/// The `RealmRepresentable` protocol is designed for types that can be represented as a `Realm` object. It provides
/// functionality to convert a model object to a Realm object and vice versa, ensuring smooth interoperability between
/// application data models and Realm database objects.
///
/// This protocol requires:
/// - An associated type `RealmType` which must conform to `Realm`'s `Object` type.
/// - A `primaryKey` property to uniquely identify objects in the database.
/// - A computed property `asRealm` to map the model object to a Realm object.
/// - An initializer `init(fromRealm:)` to map a Realm object back to the model object.
///
/// ```
/// struct MyModel: RealmRepresentable {
///     typealias RealmType = MyRealmObject
///     var primaryKey: String
///     var name: String
///
///     var asRealm: MyRealmObject {
///         // Convert to Realm object
///     }
///
///     init(fromRealm realm: MyRealmObject) {
///         // Initialize from Realm object
///     }
/// }
/// ```
public protocol RealmRepresentable {
	associatedtype RealmType: Object
	var primaryKey: String { get }
	
	var asRealm: RealmType { get }
	init(fromRealm realm: RealmType)
}
