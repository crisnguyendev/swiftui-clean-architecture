//
//  StateRenderView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/6/25.
//
import SwiftUI

struct StateRenderer<ContentData, ContentView: View>: View {
    let state: ViewState<ContentData>
    let contentView: (ContentData) -> ContentView

    var body: some View {
        switch state {
        case .loading:
            ProgressView("Loading...")
        case .loaded(let contentData):
            contentView(contentData)
        case .error(let message):
            ErrorView(message: message)
        }
    }
}
