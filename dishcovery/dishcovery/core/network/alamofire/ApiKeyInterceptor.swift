//
//  ApiKeyInterceptor.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/22/25.
//
import Foundation
import Alamofire

final class ApiKeyInterceptor: RequestAdapter, @unchecked Sendable {
    private let apiKey: String = AppConfig.apiKey
 
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var queryItems = urlComponents.queryItems ?? []

        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        urlComponents.queryItems = queryItems
        
        var adaptedRequest = urlRequest
        adaptedRequest.url = urlComponents.url

        completion(.success(adaptedRequest))
    }
}
