//
//  UserAccountTableViewCell.swift
//  MoneyBoxLight
//
//  Created by Marcus Hall on /2701/2022.
//

import UIKit

class UserAccountTableViewCell: UITableViewCell {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyBox: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    
    func displayAccounts(_ productResponse: ProductDetails) {
        accountNameLabel.text = productResponse.product.name
        planValueLabel.text = "Plan Value: £\(productResponse.planValue)"
        moneyBox.text = "Moneybox: £\(productResponse.moneyBox)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 5
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
