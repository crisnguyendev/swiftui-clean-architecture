//
//  AsyncImageView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/6/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let size: CGFloat

    var body: some View {
        Group {
            if let url = url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: size, height: size)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: size, height: size)
                            .clipped()
                    case .failure:
                        defaultImage
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                defaultImage
            }
        }
        .cornerRadius(AppDimensions.Image.cornerRadius)
    }

    private var defaultImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .foregroundColor(.gray)
    }
}
