//
//  IndividualAccountViewController.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2701/2022.
//

import UIKit

protocol IndividualAccountDelegate: AnyObject {
    func didTopUpAccount()
}

class IndividualAccountViewController: UIViewController {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyBoxLabel: UILabel!
    weak var delegate: IndividualAccountDelegate?
    
    var loginResponse: LoginResponse?
    var productDetails: ProductDetails?
    private var addMoneyService = AddMoneyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMoneyService.delegate = self
        setupLabels()
    }
    
    @IBAction func addTenPoundsButtonClicked(_ sender: Any) {
        addMoneyService.postMoney(bearerToken: loginResponse?.session.bearerToken ?? "" , investorProductId: productDetails?.id ?? 0, amount: 10)
    }
}

extension IndividualAccountViewController: AddMoneyServiceProtocol {
    func retrievedMoneyboxAmount(retrievedMoneyboxAmount: MoneyBoxResponse) {
        DispatchQueue.main.async {
            self.productDetails?.moneyBox = retrievedMoneyboxAmount.moneyBox
            self.setupLabels()
            self.delegate?.didTopUpAccount()
        }
    }
    
    func failedToRetrieveMoneyboxAmount() {
        DispatchQueue.main.async {
            self.displayAlert(title: "Error", message: "Something went wrong please try again later")
        }
    }
}

extension IndividualAccountViewController {
    func setupLabels() {
        guard
            let accountDetails = productDetails else { return }
        accountNameLabel.text = accountDetails.product.name
        planValueLabel.text = "Plan Value: £\(accountDetails.planValue)"
        moneyBoxLabel.text = "Moneybox: £\(accountDetails.moneyBox)"
    }
}

private extension IndividualAccountViewController {
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

