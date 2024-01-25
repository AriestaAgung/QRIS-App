//
//  HomeInteractor.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation

protocol HomeUseCase {
    func fetchBalance(completion: @escaping (BalanceModel?) -> Void)
    func updateBalance(_ amount: Double, completion: @escaping (BalanceModel?) -> Void)
    func addBalance(_ amount: Double, completion: @escaping (BalanceModel?) -> Void)
}

class HomeInteractor: HomeUseCase {
    func addBalance(_ amount: Double, completion: @escaping (BalanceModel?) -> Void) {
        BalanceInteractor.shared.addBalance(amount) { bal in
            completion(bal)
        }
    }
    
    static let shared = HomeInteractor()
    func fetchBalance(completion: @escaping (BalanceModel?) -> Void) {
        BalanceInteractor.shared.getBalance { balance in
            completion(balance)
        }
    }
    
    func updateBalance(_ amount: Double, completion: @escaping (BalanceModel?) -> Void) {
        BalanceInteractor.shared.updateBalance(amount) { bal in
            completion(bal)
        }
    }
    
    
}
