//
//  MenuItemRowView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/16/25.
//

import SwiftUI

struct MenuItemRowView: View {
    let menuItem: Menu
    
    var body: some View {
        HStack(alignment: .top) {
            if let url = URL(string: menuItem.image) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(8)
                .padding(.trailing, 8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(menuItem.title)
                    .font(.headline)
                Text(menuItem.restaurantChain)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 5)
    }
}
