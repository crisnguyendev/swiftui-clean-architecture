//
//  TokenManager.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/12/25.
//
import Foundation
import KeychainAccess

final class TokenManager {
    static let shared = TokenManager()
    private init() {}
    
    private let tokenStorage = TokenStorage.shared
    
    func getAccessToken() -> String? {
        return tokenStorage.accessToken
    }
    
    func getRefreshToken() -> String? {
        return tokenStorage.refreshToken
    }
    
    func saveTokens(accessToken: String, refreshToken: String) {
        tokenStorage.accessToken = accessToken
        tokenStorage.refreshToken = refreshToken
    }
    
    func clearTokens() {
        tokenStorage.accessToken = nil
        tokenStorage.refreshToken = nil
    }
    
    func refreshAccessToken() async throws -> String {
        guard let refreshToken = getRefreshToken() else {
            throw TokenError.missingRefreshToken
        }
        
        guard let url = URL(string: "https://api.spoonacular.com/auth/refresh") else {
            throw TokenError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body: [String: Any] = [
            "refresh_token": refreshToken,
            "grant_type": "refresh_token",
            "client_id": "YOUR_CLIENT_ID",
            "client_secret": "YOUR_CLIENT_SECRET"
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw TokenError.refreshFailed
        }
        
        let decoder = JSONDecoder()
        let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
        
        saveTokens(accessToken: tokenResponse.access_token, refreshToken: tokenResponse.refresh_token)
        
        return tokenResponse.access_token
    }
}
