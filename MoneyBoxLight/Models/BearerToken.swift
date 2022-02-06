//
//  BearerToken.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2901/2022.
//

import Foundation

struct BearerToken: Decodable {
    let bearerToken: String
    
    enum CodingKeys: String, CodingKey {
        case bearerToken = "BearerToken"
    }
}
