//
//  ScanQRRouter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation

protocol ScanQRRouterProtocol {
    func goToPayment(data: PaymentModel) -> PaymentViewController
}

class ScanQRRouter: ScanQRRouterProtocol {
    static let shared = ScanQRRouter()
    
    func goToPayment(data: PaymentModel) -> PaymentViewController {
        let presenter = PaymentPresenter(router: PaymentRouter.shared, interactor: PaymentInteractor.shared, data: data)
        let vc = PaymentViewController(presenter: presenter)
        return vc
    }
}
