//
//  ServingDTO.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//

struct ServingDTO: Decodable {
    let number: Double
    let size: Double?
    let unit: String?
    
    enum CodingKeys: CodingKey {
        case number
        case size
        case unit
    }
}
