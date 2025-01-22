//
//  TokenResponse.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

struct TokenResponse: Codable {
    let access_token: String
    let refresh_token: String
    let expires_in: Int
    let token_type: String
}
