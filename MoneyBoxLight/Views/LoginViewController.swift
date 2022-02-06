//
//  ViewController.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2601/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var loginResponse: LoginResponse?
    private var userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userService.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let userAccountVC = segue.destination as? UserAccountViewController else { return }
        userAccountVC.loginResponse = self.loginResponse
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        guard
            let email = emailAddressTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty else {
                displayAlert(title: "Missing Info", message: "Please provide an email address and password to login")
                return
            }
        
        userService.loginWithCredentials(email: email, password: password)
    }
}

extension LoginViewController: UserServiceProtocol {
    func retrievedUser(retrievedUser: LoginResponse) {
        self.loginResponse = retrievedUser
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toUserAccountVC", sender: self)
        }
    }
    func failedToRetrieveUser() {
        DispatchQueue.main.async {
            self.displayAlert(title: "Login Error", message: "Oops. Please try again.")
        }
    }
}

private extension LoginViewController {
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
