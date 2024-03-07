//
//  HomeRouter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit


protocol HomeRouterProtocol {
    func goToHome() -> HomeViewController
    func goToPaymentHistory(nav: UINavigationController)
    func goToQRScanner(nav: UINavigationController)
}

class HomeRouter: HomeRouterProtocol {
    static let shared = HomeRouter()
    
    func goToHome() -> HomeViewController {
        let presenter = HomePresenter(interactor: HomeInteractor.shared, router: HomeRouter.shared)
        let vc = HomeViewController(presenter: presenter)
        return vc
    }
    func goToPaymentHistory(nav: UINavigationController) {
        let presenter = PaymentHistoryPresenter(interactor: PaymentHistoryInteractor.shared, router: PaymentHistoryRouter.shared)
        let vc = PaymentHistoryViewController(presenter: presenter)
        nav.pushViewController(vc, animated: true)
    }
    func goToQRScanner(nav: UINavigationController) {
        let presenter = ScanQRPresenter(router: ScanQRRouter.shared)
        let vc = ScanQRViewController(presenter: presenter)
        nav.pushViewController(vc, animated: true)
        
    }
}
