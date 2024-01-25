//
//  PaymentHistoryViewController.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import UIKit

class PaymentHistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    private let presenter: PaymentHistoryPresenter?
    init(presenter: PaymentHistoryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Payment History"
        historyTableView.register(PaymentHistoryTableViewCell.nib, forCellReuseIdentifier: "paymentHistoryCell")
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
}

extension PaymentHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentHistoryCell", for: indexPath) as! PaymentHistoryTableViewCell
        cell.merchantLabel?.text = "Hello World"
        
        return cell
    }
    
    
}

extension PaymentHistoryViewController: UITableViewDelegate {
        
}
