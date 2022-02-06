//
//  User.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2901/2022.
//

import Foundation

struct User: Decodable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "FirstName"
        case lastName = "LastName"
    }
}
