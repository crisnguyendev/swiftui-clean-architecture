//
//  MenuItem.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

import Foundation
import SwiftData

@Model
final class MenuItem: Identifiable, Codable, Equatable {
    
    var id: Int
    var title: String
    var image: String
    var restaurantChain: String
    var servings: Serving
    
    var imageURL: URL? {
        URL(string: image)
    }
    
    init(id: Int, title: String, image: String, restaurantChain: String, servings: Serving) {
        self.id = id
        self.title = title
        self.image = image
        self.restaurantChain = restaurantChain
        self.servings = servings
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.image = try container.decode(String.self, forKey: .image)
        self.restaurantChain = try container.decode(String.self, forKey: .restaurantChain)
        self.servings = try container.decode(Serving.self, forKey: .servings)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(image, forKey: .image)
        try container.encode(restaurantChain, forKey: .restaurantChain)
        try container.encode(servings, forKey: .servings)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case image = "image"
        case restaurantChain = "restaurantChain"
        case servings = "servings"
    }
}
