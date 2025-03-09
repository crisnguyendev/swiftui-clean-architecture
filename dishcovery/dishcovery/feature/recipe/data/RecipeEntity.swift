//
//  RecipeEntity.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/5/25.
//

import SwiftData

@Model
final class RecipeEntity{
    var id: Int
    var title: String
    var image: String
    
    init(id: Int, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
    
    init(dto: RecipeDTO) {
        self.id = dto.id
        self.title = dto.title
        self.image = dto.image
    }
}
    

