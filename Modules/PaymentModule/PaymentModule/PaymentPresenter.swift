//
//  PaymentPresenter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit

protocol PaymentPresenterProtocol {
    func getData() -> PaymentModel?
    func pay(nav: UINavigationController, data: PaymentModel)
    func goToHome(nav: UINavigationController)
}

class PaymentPresenter {
    private var router: PaymentRouter?
    private var interactor: PaymentInteractor?
    private var data: PaymentModel?
    init(router: PaymentRouter? = nil, interactor: PaymentInteractor? = nil, data: PaymentModel? = nil) {
        self.router = router
        self.interactor = interactor
        self.data = data
    }
    
    func getData() -> PaymentModel? {data}
    
    func pay(nav: UINavigationController, data: PaymentModel) {
        interactor?.pay(data: data, completion: { bal in
            self.router?.goToHome(nav: nav)
        })
    }
    
    func goToHome(nav: UINavigationController) {
        self.router?.goToHome(nav: nav)
    }
}
