//
//  CoordinatorProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/10/25.
//
import SwiftUI

protocol CoordinatorProtocol: AnyObject{
    associatedtype Route: Hashable
    
    var path: NavigationPath { get set }
    
    func push(route: Route)
    func pop()
    func popToRoot()
    func destination(for route: Route) -> AnyView
}

extension CoordinatorProtocol {
    func push(route: Route) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
