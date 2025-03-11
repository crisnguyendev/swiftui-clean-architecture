//
//  RecipeItem.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//

final class RecipeModel: Identifiable, Hashable{
    
    var id: Int
    var title: String
    var image: String
    
    init(id: Int, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
    
    static func == (lhs: RecipeModel, rhs: RecipeModel) -> Bool {
        return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.image == rhs.image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(image)
    }
}
