//
//  RecipeDTO.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//
import Foundation

struct RecipeDTO: Decodable {
    let id: Int
    let title: String
    let image: String
    
    init(id: Int, title: String, image: String) {
        self .id = id
        self.title = title
        self.image = image
    }
    
    init(entity: RecipeEntity) {
        self.id = entity.id
        self.title = entity.title
        self.image = entity.image
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case image = "image"
    }
}
