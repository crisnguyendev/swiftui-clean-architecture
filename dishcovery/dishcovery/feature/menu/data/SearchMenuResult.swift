//
//  MenuSearchResponse.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation

struct SearchMenuResult: Decodable {
    let type: String
    let menus: [Menu]
    let offset: Int
    let number: Int
    let totalMenuItems: Int
    let processingTimeMs: Int
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case menus = "menuItems"
        case offset = "offset"
        case number = "number"
        case totalMenuItems = "totalMenuItems"
        case processingTimeMs = "processingTimeMs"
    }
}
