//
//  HomeViewController.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import UIKit

public class HomeViewController: UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var scanQrisButton: UIButton!
    @IBOutlet weak var addBalanceButton: UIButton!
    @IBOutlet weak var paymentHistoryButton: UIButton!
    
    private var presenter: HomePresenter?
    private var isLoadingBalance = true
    private var BalanceAction: ((Bool) -> Void)?
    private var scanAction: (() -> Void)?
    private var paymentHistoryDidTap: (() -> Void)?
    init(presenter: HomePresenter) {
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkFirstBalance()
    }
    
    private func setupUI() {
        title = "Home"
        BalanceAction = { isUpdate in
            self.isLoadingBalance = true
            if isUpdate {
                self.updateBalance()
            } else {
                self.checkFirstBalance()
            }
            
        }
        scanAction = {
            self.presenter?.routeToQris(nav: self.navigationController!)
        }
        paymentHistoryDidTap = {
            self.presenter?.routeToPaymentHistory(nav: self.navigationController!)
        }
        
        addBalanceButton.addTarget(self, action: #selector(updateBalanceAction), for: .touchUpInside)
        scanQrisButton.addTarget(self, action: #selector(scanQRAction), for: .touchUpInside)
        paymentHistoryButton.addTarget(self, action: #selector(goToPaymentHistory), for: .touchUpInside)
    }
    
    private func checkFirstBalance() {
        self.presenter?.fetchBalance { bal in
            if bal?.balance == 0 || bal?.balance == nil {
                self.presenter?.addBalance { balance in
                    if let balance {
                        DispatchQueue.main.async {
                            self.isLoadingBalance = false
                            self.balanceLabel.text = balance.balance?.description
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.isLoadingBalance = false
                            self.balanceLabel.text = bal?.balance?.description
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoadingBalance = false
                    self.balanceLabel.text = bal?.balance?.description
                }
            }
        }
    }
    private func updateBalance() {
        self.presenter?.updateBalance { bal in
            DispatchQueue.main.async {
                self.isLoadingBalance = false
                self.balanceLabel.text = bal?.balance?.description
            }
            
        }
    }
    
    @objc private func goToPaymentHistory() {
        paymentHistoryDidTap?()
    }
    
    @objc private func scanQRAction() {
        scanAction?()
    }
    
    @objc private func addBalanceAction() {
        BalanceAction?(false)
    }
    
    @objc private func updateBalanceAction() {
        BalanceAction?(true)
    }
    
}
