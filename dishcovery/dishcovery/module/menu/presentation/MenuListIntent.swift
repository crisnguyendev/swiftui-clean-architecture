//
//  MenuListIntent.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/16/25.
//
import Foundation

enum MenuListIntent {
    case fetchMenuItems
    case refreshMenuItems
    case selectMenuItem(MenuItem)
}
