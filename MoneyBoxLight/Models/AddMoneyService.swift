//
//  AddMoneyService.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /0302/2022.
//

import Foundation

protocol AddMoneyServiceProtocol {
    func retrievedMoneyboxAmount(retrievedMoneyboxAmount: MoneyBoxResponse)
    func failedToRetrieveMoneyboxAmount()
}

struct AddMoneyService {
    var delegate: AddMoneyServiceProtocol?
    
    func postMoney(bearerToken: String, investorProductId: Int, amount: Int) {
        guard let urlRequest = Endpoint().postMoneyToMoneyBox(bearerToken: bearerToken, investorProductId: investorProductId, amount: amount) else {
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { data, url, error in
            guard
                let data = data,
                let moneyBoxAmount = try? JSONDecoder().decode(MoneyBoxResponse.self, from: data) else {
                    self.delegate?.failedToRetrieveMoneyboxAmount()
                    return
                }
            self.delegate?.retrievedMoneyboxAmount(retrievedMoneyboxAmount: moneyBoxAmount)
        }.resume()
    }
}
