//
//  HomeRouter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import UIKit
class HomeRouter {
    static let shared = HomeRouter()
    
    func goToHome() -> HomeViewController {
        let presenter = HomePresenter(interactor: HomeInteractor.shared, router: HomeRouter.shared)
        let vc = HomeViewController(presenter: presenter)
        return vc
    }
    
    func goToQRScanner(nav: UINavigationController) {
        let presenter = ScanQRPresenter(router: ScanQRRouter.shared)
        let vc = ScanQRViewController(presenter: presenter)
        nav.pushViewController(vc, animated: true)
        
    }
}
