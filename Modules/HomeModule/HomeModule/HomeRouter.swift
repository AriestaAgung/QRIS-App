//
//  HomeRouter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit
import TransactionModule
import TransactionHistoryModule
import ScanQRModule

protocol HomeRouterProtocol {
    func goToHome() -> HomeViewController
    func goToPaymentHistory(nav: UINavigationController)
    func goToQRScanner(nav: UINavigationController)
}

public class HomeRouter: HomeRouterProtocol {
    public static let shared = HomeRouter()
    
    public func goToHome() -> HomeViewController {
        let presenter = HomePresenter(interactor: HomeInteractor.shared, router: HomeRouter.shared)
        let vc = HomeViewController(presenter: presenter)
        return vc
    }
    public func goToPaymentHistory(nav: UINavigationController) {
        let presenter = PaymentHistoryPresenter(interactor: PaymentHistoryInteractor.shared, router: PaymentHistoryRouter.shared)
        let vc = PaymentHistoryViewController(presenter: presenter)
        nav.pushViewController(vc, animated: true)
    }
    public func goToQRScanner(nav: UINavigationController) {
        let presenter = ScanQRPresenter(router: ScanQRRouter.shared)
        let vc = ScanQRViewController(presenter: presenter)
        nav.pushViewController(vc, animated: true)
        
    }
}
