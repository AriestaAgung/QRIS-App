//
//  PaymentRouter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit

protocol PaymentRouterProtocol {
    func goToHome(nav: UINavigationController)
}

public class PaymentRouter: PaymentRouterProtocol {
    public static let shared = PaymentRouter()
    
    public func goToHome(nav: UINavigationController) {
        DispatchQueue.main.async {
            nav.popToRootViewController(animated: true)            
        }
    }
}
