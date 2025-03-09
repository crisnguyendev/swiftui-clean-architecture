//
//  MenuModel.swift.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

import Foundation
import SwiftData

final class MenuModel: Identifiable, Equatable {
    var id: Int
    var title: String
    var image: String
    var restaurantChain: String
    var servings: ServingModel
    
    init(id: Int, title: String, image: String, restaurantChain: String, servings: ServingModel) {
        self.id = id
        self.title = title
        self.image = image
        self.restaurantChain = restaurantChain
        self.servings = servings
    }
    
    static func == (lhs: MenuModel, rhs: MenuModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.image == rhs.image &&
        lhs.restaurantChain == rhs.restaurantChain &&
        lhs.servings == rhs.servings
    }
}
