//
//  PaymentInteractor.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation

class PaymentInteractor {
    static let shared = PaymentInteractor()
    
    func pay(data: PaymentModel, completion: @escaping (BalanceModel?) -> Void) {
        BalanceInteractor.shared.updateBalance(data.amount ?? 0, isMinus: true, completion: { bal in
            let transaction = TransactionModel(
                transactionId: data.id,
                merchantName: data.merchantName,
                amount: data.amount
            )
            TransactionInteractor.shared.addTransaction(data: transaction, completion: { _ in
                completion(bal)
            })
        })
    }
}
