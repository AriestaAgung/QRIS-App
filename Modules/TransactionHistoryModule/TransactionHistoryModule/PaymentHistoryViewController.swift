//
//  PaymentHistoryViewController.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import UIKit

public class PaymentHistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var emptyViewLabel: UILabel!
    private let presenter: PaymentHistoryPresenter?
    private var isLoadingData = true
    public init(presenter: PaymentHistoryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Payment History"
        historyTableView.register(PaymentHistoryTableViewCell.nib, forCellReuseIdentifier: "paymentHistoryCell")
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.allowsSelection = false
        presenter?.fetchPaymentData { transactions in
            self.isLoadingData = false
            DispatchQueue.main.async {
                if transactions.count == 0 {
                    self.historyTableView.isHidden = true
                    self.emptyViewLabel.isHidden = false
                } else {
                    self.historyTableView.isHidden = false
                    self.emptyViewLabel.isHidden = true
                }
                self.historyTableView.reloadData()
                
            }
        }
    }
}

extension PaymentHistoryViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getPaymentData().count ?? 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentHistoryCell", for: indexPath) as! PaymentHistoryTableViewCell
        if isLoadingData {
            cell.merchantLabel?.text = "..."
            cell.amountLabel.text = "..."
        } else {
            cell.merchantLabel.text = presenter?.getPaymentData()[indexPath.row]?.merchantName
            cell.amountLabel.text = "Rp" + (presenter?.getPaymentData()[indexPath.row]?.amount?.description ?? "0")
        }
        
        return cell
    }
    
    
}

extension PaymentHistoryViewController: UITableViewDelegate {
        
}
