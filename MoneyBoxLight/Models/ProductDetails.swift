//
//  Accounts.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /0202/2022.
//

import Foundation

class ProductDetails: Decodable {
    let id: Int
    let planValue: Double
    var moneyBox: Double
    let product: Product
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case planValue = "PlanValue"
        case moneyBox = "Moneybox"
        case product = "Product"
    }
}
