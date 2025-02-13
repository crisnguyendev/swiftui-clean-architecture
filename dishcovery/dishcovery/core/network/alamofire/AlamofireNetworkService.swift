//
//  AlamofireNetworkService.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/12/25.
//

import Alamofire
import Foundation

final class AlamofireNetworkService: NetworkServiceProtocol {
    private let session: Session

    init(session: Session = NetworkSessionProvider.makeSession()) {
        self.session = session
    }
    
    func performRequest<T: Decodable>(_ request: APIRequest) async throws -> T {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue

        if let headers = request.hearders {
            for (headerField, headerValue) in headers {
                urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }

        if let queryParameters = request.queryParams, request.method == .get {
            if var urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: false) {
                var existingQueryItems = urlComponents.queryItems ?? []
                let newQueryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                existingQueryItems.append(contentsOf: newQueryItems)
                urlComponents.queryItems = existingQueryItems
                if let updatedURL = urlComponents.url {
                    urlRequest.url = updatedURL
                }
            }
        }
        
        if let body = request.body, request.method != .get {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(AnyEncodable(body))
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }

        return try await withCheckedThrowingContinuation { continuation in
            session.request(urlRequest)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
