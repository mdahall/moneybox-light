//
//  File.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2701/2022.
//

import Foundation

struct LoginResponse: Decodable {
    let user: User
    let session: BearerToken
    
    enum CodingKeys: String, CodingKey {
        case user = "User"
        case session = "Session"
    }
}
