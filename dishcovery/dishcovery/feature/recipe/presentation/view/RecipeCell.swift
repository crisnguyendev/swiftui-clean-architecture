//
//  RecipeCell.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/6/25.
//

import SwiftUI

struct RecipeCell: View {
    let recipe: RecipeModel
    
    var body: some View {
        HStack(alignment: .center) {
            recipeImage
            Text(recipe.title)
                .font(.headline)
        }
    }
    
    
    private var recipeImage: some View {
        AsyncImageView(
            url: URL(string: recipe.image),
            size: AppDimensions.Image.Size.medium
        )
        .padding(.trailing, AppDimensions.Spacing.small)
    }
}


