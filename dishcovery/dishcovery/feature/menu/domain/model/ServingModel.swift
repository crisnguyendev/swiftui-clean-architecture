//
//  ServingModel.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

final class ServingModel: Equatable{
    let number: Double
    let size: Double?
    let unit: String?
    
    init(number: Double, size: Double?, unit: String?) {
        self.number = number
        self.size = size
        self.unit = unit
    }
    
    static func == (lhs: ServingModel, rhs: ServingModel) -> Bool {
        return lhs.number == rhs.number &&
        lhs.size == rhs.size &&
        lhs.unit == rhs.unit
    }
}
