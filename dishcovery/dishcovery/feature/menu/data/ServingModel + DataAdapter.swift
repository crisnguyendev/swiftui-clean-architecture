//
//  ServingModel + DataAdapter.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//

extension ServingModel {
    convenience init(dto: ServingDTO) {
        self.init(
            number: dto.number,
            size: dto.size,
            unit: dto.unit)
    }
}
