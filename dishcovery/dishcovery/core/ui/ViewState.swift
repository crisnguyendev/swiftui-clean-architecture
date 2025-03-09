//
//  ViewState.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/6/25.
//

enum ViewState<ContentData> {
    case loading
    case loaded(ContentData)
    case error(String)
}
