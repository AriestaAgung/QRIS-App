//
//  PaymentHistoryInteractor.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import TransactionModule

protocol PaymentHistoryUseCase {
    func getTransaction(completion: @escaping ([TransactionModel?]) -> Void)
}

public class PaymentHistoryInteractor: PaymentHistoryUseCase {
    public static let shared = PaymentHistoryInteractor()
    
    public func getTransaction(completion: @escaping ([TransactionModel?]) -> Void) {
        TransactionInteractor.shared.getTransaction { transactions in
            completion(transactions)
        }
    }
    
}
