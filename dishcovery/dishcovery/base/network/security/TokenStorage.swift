//
//  TokenStorage.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation
import Security

final class TokenStorage {
    static let shared = TokenStorage()
    private init() {}
    
    private let service = "com.yourapp.service"
    private let accessTokenAccount = "accessToken"
    private let refreshTokenAccount = "refreshToken"
    
    var accessToken: String? {
        get {
            return retrieveToken(account: accessTokenAccount)
        }
        set {
            if let token = newValue {
                storeToken(token, account: accessTokenAccount)
            } else {
                deleteToken(account: accessTokenAccount)
            }
        }
    }
    
    var refreshToken: String? {
        get {
            return retrieveToken(account: refreshTokenAccount)
        }
        set {
            if let token = newValue {
                storeToken(token, account: refreshTokenAccount)
            } else {
                deleteToken(account: refreshTokenAccount)
            }
        }
    }
    
    private func storeToken(_ token: String, account: String) {
        let data = Data(token.utf8)
        deleteToken(account: account)
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecValueData as String   : data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Error storing token for account \(account): \(status)")
        }
    }
    
    private func retrieveToken(account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr, let data = dataTypeRef as? Data, let token = String(data: data, encoding: .utf8) {
            return token
        }
        return nil
    }
    
    private func deleteToken(account: String) {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account
        ]
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            print("Error deleting token for account \(account): \(status)")
        }
    }
}
