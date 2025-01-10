//
//  RecipeModel.swift
//  dishcovery
//
//  Created by Vu Nguyen on 12/27/24.
//

import SwiftData

@Model
class RecipeModel {
    var id: String
    var name: String
    var imageUrl: String
    
    init(id: String, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
