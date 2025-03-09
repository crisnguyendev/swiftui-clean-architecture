//
//  URLSessionNetworkService.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//
import Foundation

final class URLSessionNetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let logger: LoggerProtocol
    
    init() {
        self.session = URLSession(configuration: .default)
        self.decoder = JSONDecoder()
        self.logger = SwiftyBeaverLogger.shared
    }
    
    func performRequest<T>(_ request: APIRequest) async throws -> T where T : Decodable {
        var urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: false)
    
        if let queryParams = request.queryParams {
            urlComponents?.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        logger.log(urlRequest.cURL, level: .info)
        let (data, response) = try await session.data(for: urlRequest)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        let decodedObject = try decoder.decode(T.self, from: data)
        
        return decodedObject
    }
}
