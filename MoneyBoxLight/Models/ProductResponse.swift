//
//  InvestorProducts.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /0202/2022.
//

import Foundation

struct ProductResponse: Decodable {
    let totalPlanValue: Double
    let productResponses: [ProductDetails]
    
    enum CodingKeys: String, CodingKey {
        case totalPlanValue = "TotalPlanValue"
        case productResponses = "ProductResponses"
    }
}
