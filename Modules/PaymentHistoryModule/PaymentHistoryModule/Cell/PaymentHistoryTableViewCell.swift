//
//  PaymentHistoryTableViewCell.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import UIKit

class PaymentHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var merchantLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    static let nib = UINib(nibName: "PaymentHistoryTableViewCell", bundle: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
