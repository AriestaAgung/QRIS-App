//
//  PaymentEntity.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation

public struct PaymentModel {
    public init(id: String?, bankOrigin: String?, merchantName: String?, amount: Double?) {
        self.id = id
        self.bankOrigin = bankOrigin
        self.merchantName = merchantName
        self.amount = amount
    }
    public let id: String?
    public let bankOrigin: String?
    public let merchantName: String?
    public let amount: Double?
}
