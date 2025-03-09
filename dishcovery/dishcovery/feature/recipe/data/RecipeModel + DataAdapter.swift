//
//  RecipeModel + DataAdapter.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//

extension RecipeModel {
    convenience init(dto: RecipeDTO) {
        self.init(id: dto.id, title: dto.title, image: dto.image)
    }
    
    convenience init(entity: RecipeEntity){
        self.init(id: entity.id, title: entity.title, image: entity.image)
    }
}
