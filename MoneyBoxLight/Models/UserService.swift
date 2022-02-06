//
//  UserService.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2701/2022.
//

import Foundation


//po try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

protocol UserServiceProtocol {
    func retrievedUser(retrievedUser: LoginResponse)
    func failedToRetrieveUser()
}

struct UserService {
    var delegate: UserServiceProtocol?
    
    func loginWithCredentials(email: String, password: String) {
        guard let urlRequest = Endpoint().login(email: email, password: password) else {
            delegate?.failedToRetrieveUser()
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard
                let data = data,
                let user = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                    self.delegate?.failedToRetrieveUser()
                    return
                }
            self.delegate?.retrievedUser(retrievedUser: user)
        }.resume()
    }
}
