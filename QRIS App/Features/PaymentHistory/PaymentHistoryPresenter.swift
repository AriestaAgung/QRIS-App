//
//  PaymentHistoryPresenter.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation

class PaymentHistoryPresenter {
    private var interactor: PaymentHistoryInteractor?
    private var router: PaymentHistoryRouter?
    private var transactionData: [TransactionModel?]! = []
    init(interactor: PaymentHistoryInteractor? = nil, router: PaymentHistoryRouter? = nil) {
        self.interactor = interactor
        self.router = router
    }
    func getPaymentData() -> [TransactionModel?]! {
        return transactionData
    }
    func fetchPaymentData(completion: @escaping ([TransactionModel?]) -> Void) {
        interactor?.getTransaction { transactions in
            self.transactionData = transactions
            completion(transactions)
        }
    }
}
