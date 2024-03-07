//
//  PaymentViewController.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import UIKit

public class PaymentViewController: UIViewController {

    @IBOutlet weak var transactionIDLabel: UILabel!
    @IBOutlet weak var merchantNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    private var didTapCancel: (() -> Void)?
    private var didTapPay: (() -> Void)?
    private var presenter: PaymentPresenter?
    public init(presenter: PaymentPresenter) {
        self.presenter = presenter
        let bundle = Bundle(identifier: "com.dcd.PaymentModule")
        super.init(nibName: nil, bundle: bundle!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    private func setupUI() {
        title = "Payment Detail"
        payButton.layer.cornerRadius = 10
        didTapCancel = {
            self.presenter?.goToHome(nav: self.navigationController!)
        }
        didTapPay = {
            if let data = self.presenter?.getData() {
                self.presenter?.pay(nav: self.navigationController!, data: data)
            }
        }
        self.transactionIDLabel.text = presenter?.getData()?.id ?? ""
        self.merchantNameLabel.text = presenter?.getData()?.merchantName ?? ""
        self.amountLabel.text = "Rp" + (presenter?.getData()?.amount?.description ?? "")
        self.payButton.addTarget(self, action: #selector(payAction), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
    
    @objc private func cancelAction() {
        didTapCancel?()
    }
    
    @objc private func payAction() {
        didTapPay?()
    }


}
