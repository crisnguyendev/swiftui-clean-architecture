//
//  MenuDetailView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/17/25.
//

import SwiftUI
import SwiftData

struct MenuDetailView: View {
    let menuItem: MenuItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Display Menu Item Image
                if let url = URL(string: menuItem.image) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    // Placeholder Image if URL is Invalid
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                }

                // Menu Item Title
                Text(menuItem.title)
                    .font(.title)
                    .bold()

                // Additional Information (Optional)
                // Uncomment and adjust if `restaurantChain` and `servings` are used.
                /*
                if let restaurantChain = menuItem.restaurantChain {
                    Text("Restaurant: \(restaurantChain)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let servings = menuItem.servings {
                    if let size = servings.size, let unit = servings.unit {
                        Text("Servings: \(servings.number) x \(size) \(unit)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Servings: \(servings.number)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                */

                Spacer()
            }
            .padding()
        }
        .navigationTitle(menuItem.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
