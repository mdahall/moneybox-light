//
//  ProductService.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on 01/02/2022.
//

import Foundation

//po try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

protocol ProductServiceProtocol {
    func retrievedProducts(retrievedProducts: ProductResponse)
    func failedToRetrieveProducts()
}

struct ProductService {
    var delegate: ProductServiceProtocol?
    
    func retrieveInvestorProductsWithBearerToken(bearerToken: String) {
        guard let urlRequest = Endpoint().investorProducts(bearerToken: bearerToken) else {
            delegate?.failedToRetrieveProducts()
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { data, url, error in
            guard
                let data = data,
                let investorProducts = try? JSONDecoder().decode(ProductResponse.self, from: data) else {
                    self.delegate?.failedToRetrieveProducts()
                    return
                }
            self.delegate?.retrievedProducts(retrievedProducts: investorProducts)
        }.resume()
    }
}
