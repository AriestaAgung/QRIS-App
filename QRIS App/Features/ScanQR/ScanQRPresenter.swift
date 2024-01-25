//
//  ScanQRPresenter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit

class ScanQRPresenter {
    private var router: ScanQRRouter?
    init(router: ScanQRRouter? = nil) {
        self.router = router
    }
    
    func goToPayment(nav: UINavigationController, data: PaymentModel) {
        if let vc = router?.goToPayment(data: data) {
            nav.pushViewController(vc, animated: true)
        }
    }
}
