//
//  URLRequest + cURL.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/2/25.
//
import Foundation

extension URLRequest {
    var cURL: String {
        guard let url = self.url else {
            return "Invalid URL"
        }
        var components = ["cURL"]
        
        if let method = self.httpMethod, method != "GET" {
            components.append("-X \(method)")
        }
        
        if let headers = self.allHTTPHeaderFields {
            for (key, value) in headers {
                components.append("-H \"\(key): \(value)\"")
            }
        }
        
        if let httpBody = self.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
            // Escape quotes in body if needed
            let escapedBody = bodyString.replacingOccurrences(of: "\"", with: "\\\"")
            components.append("-d \"\(escapedBody)\"")
        }
        
        components.append("\"\(url.absoluteString)\"")
        
        return components.joined(separator: " ")
    }
}
