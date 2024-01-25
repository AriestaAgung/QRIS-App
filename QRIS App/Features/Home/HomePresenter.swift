//
//  HomePresenter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit
protocol HomePresenterProtocol {
    func fetchBalance(completion: @escaping (BalanceModel?) -> Void)
    func addBalance(completion: @escaping (BalanceModel?) -> Void)
    func updateBalance(completion: @escaping (BalanceModel?) -> Void)
    func routeToQris(nav: UINavigationController)
    func routeToPaymentHistory()
}

class HomePresenter: HomePresenterProtocol {
    private var interactor: HomeInteractor?
    private var router: HomeRouter?
    private var balanceModel: BalanceModel?
    init(interactor: HomeInteractor? = nil, router: HomeRouter? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    
    func fetchBalance(completion: @escaping (BalanceModel?) -> Void) {
        
        interactor?.fetchBalance{ balance in
            if let balance {
                self.balanceModel = balance
                completion(self.balanceModel)
            } else {
                completion(nil)
            }
        }
    }
    func addBalance(completion: @escaping (BalanceModel?) -> Void) {
        interactor?.addBalance(500000) { bal in
            print("presenter - add balance \(bal)")
            if let bal {
                self.balanceModel = bal
                completion(bal)
            } else {
                completion(nil)
            }
        }
    }
    func updateBalance(completion: @escaping (BalanceModel?) -> Void) {
        interactor?.updateBalance(500000) { bal in
            completion(bal)
        }
    }
    
    func routeToQris(nav: UINavigationController) {
        router?.goToQRScanner(nav: nav)
    }
    
    func routeToPaymentHistory() {
        
    }
    
    
}
