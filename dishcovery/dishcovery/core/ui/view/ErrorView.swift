//
//  ErrorView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/6/25.
//

import SwiftUI

struct ErrorView: View {
    let message: String

    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
                .padding()
        }
    }
}
