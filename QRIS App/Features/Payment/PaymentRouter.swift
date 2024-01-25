//
//  PaymentRouter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit
class PaymentRouter {
    static let shared = PaymentRouter()
    
    func goToHome(nav: UINavigationController) {
        nav.popToRootViewController(animated: true)
    }
}
