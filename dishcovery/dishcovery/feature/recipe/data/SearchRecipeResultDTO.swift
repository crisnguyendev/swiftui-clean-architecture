//
//  SearchRecipeResultDTO.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//

struct SearchRecipeResultDTO: Decodable {
    let data: [RecipeDTO]
    let offset: Int
    let number: Int
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case data = "results"
        case offset = "offset"
        case number = "number"
        case total = "totalResults"
    }
}
