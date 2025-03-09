//
//  MenuCell.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/16/25.
//

import SwiftUI

struct MenuCell: View {
    let data: MenuModel
    
    var body: some View {
        HStack(alignment: .center) {
            recipeImage
            Text(data.title)
                .font(.headline)
        }
    }
    
    
    private var recipeImage: some View {
        AsyncImageView(
            url: URL(string: data.image),
            size: AppDimensions.Image.Size.medium
        )
        .padding(.trailing, AppDimensions.Spacing.small)
    }
}
