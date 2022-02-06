//
//  Wrapper.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /0202/2022.
//

import Foundation

struct Product: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "FriendlyName"
    }
}
