//
//  UserAccountViewController.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2701/2022.
//

import UIKit

class UserAccountViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalPlanValueLabel: UILabel!
    @IBOutlet weak var userAccountTableView: UITableView!
    
    var loginResponse: LoginResponse?
    var productResponses: ProductResponse?
    private var productService = ProductService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        configureProductService()
        configureTableView()
    }
}

extension UserAccountViewController {
    func configureProductService() {
        productService.delegate = self
        productService.retrieveInvestorProductsWithBearerToken(bearerToken: loginResponse?.session.bearerToken ?? "")
    }
}

extension UserAccountViewController: IndividualAccountDelegate {
    func configureTableView() {
        userAccountTableView.delegate = self
        userAccountTableView.dataSource = self
        userAccountTableView.rowHeight = UITableView.automaticDimension
        userAccountTableView.estimatedRowHeight = 115
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = userAccountTableView.indexPathForSelectedRow else { return }
        let productDetails = productResponses?.productResponses[indexPath.row]
        let destinationVC = segue.destination as! IndividualAccountViewController
        destinationVC.productDetails = productDetails
        destinationVC.delegate = self
        destinationVC.loginResponse = self.loginResponse
    }
    func didTopUpAccount() {
        DispatchQueue.main.async {
            self.userAccountTableView.reloadData()
        }
    }
}

extension UserAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productResponses?.productResponses.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userAccountTableView.dequeueReusableCell(withIdentifier: "userAccountCell", for: indexPath) as! UserAccountTableViewCell
        let accounts = productResponses?.productResponses[indexPath.row]
        guard let productResponse = accounts else { return cell }
        cell.displayAccounts(productResponse)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toIndividualAccountVC", sender: self)
    }
}

private extension UserAccountViewController {
    func updateNameAndValueLabel() {
        guard
            let user = loginResponse?.user,
            let productResponse = productResponses
        else { return }
        nameLabel.text = "Hello \(user.firstName)"
        totalPlanValueLabel.text = "Total Plan Value: £\(productResponse.totalPlanValue)"
    }
}

extension UserAccountViewController: ProductServiceProtocol {
    func retrievedProducts(retrievedProducts: ProductResponse) {
        DispatchQueue.main.async {
            self.productResponses = retrievedProducts
            self.updateNameAndValueLabel()
            self.userAccountTableView.reloadData()
        }
    }
    
    func failedToRetrieveProducts() {
        DispatchQueue.main.async {
            self.displayAlert(title: "Oops!", message: "Something went wrong please try again later")
        }
    }
}

private extension UserAccountViewController {
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
