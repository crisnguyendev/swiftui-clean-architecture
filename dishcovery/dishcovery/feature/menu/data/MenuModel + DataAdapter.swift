//
//  MenuModel + DataAdapter.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//

extension MenuModel {
    convenience init(dto: MenuDTO) {
        self.init(
            id: dto.id,
            title: dto.title,
            image: dto.image,
            restaurantChain: dto.restaurantChain,
            servings: ServingModel.init(dto: dto.servings)
        )
    }
}
