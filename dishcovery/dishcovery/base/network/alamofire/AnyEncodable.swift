//
//  AnyEncodable.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/22/25.
//

struct AnyEncodable: Encodable {
    private let encode: (Encoder) throws -> Void

    init<T: Encodable>(_ wrapped: T) {
        self.encode = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try encode(encoder)
    }
}
