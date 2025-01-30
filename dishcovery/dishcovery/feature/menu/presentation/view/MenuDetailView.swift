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
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                }

                Text(menuItem.title)
                    .font(.title)
                    .bold()

                Spacer()
            }
            .padding()
        }
        .navigationTitle(menuItem.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
