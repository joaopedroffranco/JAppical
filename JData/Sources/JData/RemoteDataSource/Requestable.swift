// Created in 2025

import Foundation

/// The possible types of HTTP request methods.
public enum RequestMethod {
	case get
	case post
	case put
}

/// A set of computed properties to generate different types of HTTP requests based on the method specified.
///
/// This protocol provides computed properties to create `URLRequest` objects for GET, POST, and PUT methods. It ensures
/// that each request is properly configured with the necessary URL, headers, parameters, and HTTP method based on the
/// context of the request type.
///
/// The `Requestable` provides:
/// - A computed `request` property that returns the appropriate `URLRequest` based on the specified HTTP method.
/// - Methods for constructing GET, POST, and PUT requests with the necessary parameters and headers.
///
/// ```
/// let request = myRequestableInstance.request
/// ```
public protocol Requestable {
	var method: RequestMethod { get }
	var host: String { get }
	var endpoint: String { get }
	var params: [String: Any]? { get }
	var headers: [String: String]? { get }
	var cachePolicy: URLRequest.CachePolicy { get }
	var request: URLRequest? { get }
}

public extension Requestable {
	var request: URLRequest? {
		switch method {
		case .get: return getRequest
		case .post: return postRequest
		case .put: return putRequest
		}
	}

	private var urlString: String { host + endpoint }

	private var getRequest: URLRequest? {
		var urlComponents = URLComponents(string: urlString)
		urlComponents?.queryItems = params?.map {
			URLQueryItem(name: $0.key, value: $0.value as? String)
		}

		guard
			let string = urlComponents?.string,
			let url = URL(string: string)
		else {
			return nil
		}

		var request = URLRequest(url: url, cachePolicy: cachePolicy)
		headers?.forEach {
			request.setValue($0.key, forHTTPHeaderField: $0.value)
		}

		return request
	}

	private var postRequest: URLRequest? {
		guard let url = URL(string: urlString) else { return nil }

		var request = URLRequest(url: url, cachePolicy: cachePolicy)
		headers?.forEach {
			request.setValue($0.key, forHTTPHeaderField: $0.value)
		}
		request.httpMethod = "POST"

		if let params = params {
			request.httpBody = try? JSONSerialization.data(
				withJSONObject: params
			)
		}

		return request
	}
	
	private var putRequest: URLRequest? {
		guard let url = URL(string: urlString) else { return nil }

		var request = URLRequest(url: url, cachePolicy: cachePolicy)
		headers?.forEach {
			request.setValue($0.key, forHTTPHeaderField: $0.value)
		}
		request.httpMethod = "PUT"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")

		if let params = params {
			request.httpBody = try? JSONSerialization.data(
				withJSONObject: params
			)
		}

		return request
	}
}
