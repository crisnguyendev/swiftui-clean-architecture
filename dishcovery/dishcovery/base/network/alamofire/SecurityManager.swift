//
//  SecurityManager.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Alamofire

struct SecurityManager {
    static func makeServerTrustManager() -> ServerTrustManager {
        let evaluators: [String: ServerTrustEvaluating] = [
            "api.spoonacular.com": PinnedCertificatesTrustEvaluator()
            // Add more hosts and their evaluators as needed
        ]
        
        return ServerTrustManager(evaluators: evaluators)
    }
}
