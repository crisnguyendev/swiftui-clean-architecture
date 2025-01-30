//
//  MenuListState.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/16/25.
//

import Foundation

struct MenuListState: Equatable {
    var isLoading: Bool = false
    var menuItems: [MenuItem] = []
    var errorMessage: String?
    
    static func == (lhs: MenuListState, rhs: MenuListState) -> Bool {
        return lhs.isLoading == rhs.isLoading &&
               lhs.menuItems == rhs.menuItems &&
               lhs.errorMessage == rhs.errorMessage
    }
}
