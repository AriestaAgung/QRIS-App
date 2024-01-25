//
//  PaymentHistoryInteractor.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation

class PaymentHistoryInteractor {
    static let shared = PaymentHistoryInteractor()
    
    func getTransaction(completion: @escaping ([TransactionModel?]) -> Void) {
        TransactionInteractor.shared.getTransaction { transactions in
            completion(transactions)
        }
    }
    
}