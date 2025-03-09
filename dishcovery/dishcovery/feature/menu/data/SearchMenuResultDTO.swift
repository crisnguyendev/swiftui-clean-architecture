//
//  SearchMenuResultDTO.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation

struct SearchMenuResultDTO: Decodable {
    let data: [MenuDTO]
    let offset: Int
    let limit: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case data = "menuItems"
        case offset = "offset"
        case limit = "number"
        case totalResults = "totalMenuItems"
    }
}
