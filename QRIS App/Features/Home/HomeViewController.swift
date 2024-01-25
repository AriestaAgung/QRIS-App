//
//  HomeViewController.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var scanQrisButton: UIButton!
    @IBOutlet weak var addBalanceButton: UIButton!
    @IBOutlet weak var paymentHistoryButton: UIButton!
    
    private var presenter: HomePresenter?
    private var isLoadingBalance = true
    private var buttonAction: ((Bool) -> Void)?
    init(presenter: HomePresenter) {
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
        title = "Home"
        buttonAction = { isUpdate in
            self.isLoadingBalance = true
            if isUpdate {
                self.updateBalance()
            } else {
                self.checkFirstBalance()
            }
            
        }
        checkFirstBalance()
        addBalanceButton.addTarget(self, action: #selector(updateBalanceAction), for: .touchUpInside)
    }
    
    private func checkFirstBalance() {
        self.presenter?.fetchBalance { bal in
            if bal?.balance == 0 || bal?.balance == nil {
                self.presenter?.addBalance { balance in
                    print(balance)
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
    
    @objc private func addBalanceAction() {
        buttonAction?(false)
    }
    
    @objc private func updateBalanceAction() {
        buttonAction?(true)
    }
    
}
