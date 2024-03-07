//
//  PaymentHistoryInteractor.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation

protocol PaymentHistoryUseCase {
    func getTransaction(completion: @escaping ([TransactionModel?]) -> Void)
}

class PaymentHistoryInteractor: PaymentHistoryUseCase {
    static let shared = PaymentHistoryInteractor()
    
    func getTransaction(completion: @escaping ([TransactionModel?]) -> Void) {
        TransactionInteractor.shared.getTransaction { transactions in
            completion(transactions)
        }
    }
    
}
