//
//  Endpoint.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2701/2022.
//

import Foundation

enum HTTPHeaders: String {
    case appID = "AppId"
    case contentType = "Content-Type"
    case appVersion
    case apiVersion
    case authorization = "Authorization"
}

struct Endpoint {
    private let baseURL = "https://api-test02.moneyboxapp.com/"
    private let login = "users/login"
    private let investorProducts = "investorproducts"
    private let oneOffPayments = "oneoffpayments"
    
    
    func login(email: String, password: String) -> URLRequest? {
        let urlString = baseURL.appending(login)
        guard let url = URL(string: urlString) else { return nil }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.allHTTPHeaderFields = retrieveDefaultHeaders()
        
        let json: [String: Any] = ["email": email,
                                   "password": password,
                                   "Idfa": "ANYTHING"]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else { return nil }
        urlRequest.httpBody = jsonData
        urlRequest.httpMethod = "POST"
        
        return urlRequest
    }
    
    func investorProducts(bearerToken: String) -> URLRequest? {
        let urlString = baseURL.appending(investorProducts)
        guard let url = URL(string: urlString) else { return nil }
        var urlRequest = URLRequest(url: url)
        
        var headers = retrieveDefaultHeaders()
        headers[HTTPHeaders.authorization.rawValue] = "Bearer \(bearerToken)"
        urlRequest.allHTTPHeaderFields = headers
        
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    func postMoneyToMoneyBox(bearerToken: String, investorProductId: Int, amount: Int) -> URLRequest? {
        let urlString = baseURL.appending(oneOffPayments)
        guard let url = URL(string: urlString) else { return nil }
        var urlRequest = URLRequest(url: url)
        
        var headers = retrieveDefaultHeaders()
        headers[HTTPHeaders.authorization.rawValue] = "Bearer \(bearerToken)"
        urlRequest.allHTTPHeaderFields = headers
        
        let json: [String: Any] = ["Amount": 10,
                                   "InvestorProductId": investorProductId]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else { return nil }
        urlRequest.httpBody = jsonData
        urlRequest.httpMethod = "POST"
        
        return urlRequest
    }
}

private extension Endpoint {
    func retrieveDefaultHeaders() -> [String : String] {
        return [HTTPHeaders.appID.rawValue: Constants.appID,
                HTTPHeaders.contentType.rawValue: Constants.contentType,
                HTTPHeaders.appVersion.rawValue: Constants.appVersion,
                HTTPHeaders.apiVersion.rawValue: Constants.apiVersion]
    }
}
