//
//  HomePresenter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit
import BalanceModule

protocol HomePresenterProtocol {
    func fetchBalance(completion: @escaping (BalanceModel?) -> Void)
    func addBalance(completion: @escaping (BalanceModel?) -> Void)
    func updateBalance(completion: @escaping (BalanceModel?) -> Void)
    func routeToQris(nav: UINavigationController)
    func routeToPaymentHistory(nav: UINavigationController)
}

public class HomePresenter: HomePresenterProtocol {
    private var interactor: HomeInteractor?
    private var router: HomeRouter?
    private var balanceModel: BalanceModel?
    init(interactor: HomeInteractor? = nil, router: HomeRouter? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    
    public func fetchBalance(completion: @escaping (BalanceModel?) -> Void) {
        
        interactor?.fetchBalance{ balance in
            if let balance {
                self.balanceModel = balance
                completion(self.balanceModel)
            } else {
                completion(nil)
            }
        }
    }
    public func addBalance(completion: @escaping (BalanceModel?) -> Void) {
        interactor?.addBalance(500000) { bal in
            if let bal {
                self.balanceModel = bal
                completion(bal)
            } else {
                completion(nil)
            }
        }
    }
    public func updateBalance(completion: @escaping (BalanceModel?) -> Void) {
        interactor?.updateBalance(500000) { bal in
            completion(bal)
        }
    }
    
    public func routeToQris(nav: UINavigationController) {
        router?.goToQRScanner(nav: nav)
    }
    
    public func routeToPaymentHistory(nav: UINavigationController) {
        router?.goToPaymentHistory(nav: nav)
    }
    
    
}
