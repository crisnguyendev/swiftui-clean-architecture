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

    func fetch<T: Decodable>(from url: URL) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url).validate().responseDecodable(of: T.self) { response in
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
