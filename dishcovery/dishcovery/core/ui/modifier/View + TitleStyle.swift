//
//  TitleStyleModifier.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/23/25.
//
import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .bold()
            .scaledToFit()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleStyle())
    }
}
