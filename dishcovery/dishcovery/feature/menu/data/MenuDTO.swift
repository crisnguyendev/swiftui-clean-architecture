//
//  MenuDTO.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//

struct MenuDTO: Decodable {
    let id: Int
    let title: String
    let image: String
    let restaurantChain: String
    let servings: ServingDTO
    
    init(id: Int, title: String, image: String, restaurantChain: String, servings: ServingDTO) {
        self.id = id
        self.title = title
        self.image = image
        self.restaurantChain = restaurantChain
        self.servings = servings
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case image = "image"
        case restaurantChain = "restaurant_chain"
        case servings = "servings"
    }
}
