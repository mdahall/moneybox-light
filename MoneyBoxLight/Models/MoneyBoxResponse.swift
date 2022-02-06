//
//  MoneyBoxResponse.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /0502/2022.
//

import Foundation

struct MoneyBoxResponse: Decodable {
    let moneyBox: Double
    
    enum CodingKeys: String, CodingKey {
        case moneyBox = "Moneybox"
    }
}
