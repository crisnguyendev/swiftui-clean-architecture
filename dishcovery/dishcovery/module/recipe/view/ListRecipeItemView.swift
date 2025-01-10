//
//  ListRecipeItemView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 12/27/24.
//
import SwiftUI

struct ListRecipeItemView: View {
    var model: RecipeModel
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: model.imageUrl)) { phase in
                switch phase {
                case.empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                        .clipped()
                    
                case .failure:
                    Image(systemName: "exclamationmark")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
            .background(Color.red)
            .cornerRadius(16)
            
            Text(model.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .foregroundStyle(Color.black)
        .shadow(radius: 16)
        .frame(maxWidth: 208, maxHeight: 208)
    }
    
    init(model: RecipeModel) {
        self.model = model
    }
}

#Preview {
    let model = RecipeModel(id: "123", name: "The Easiest Beef Pho", imageUrl: "https://img.spoonacular.com/recipes/1096211-312x231.jpg")
    ListRecipeItemView(model: model)
}
