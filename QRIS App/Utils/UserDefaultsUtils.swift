//
//  UserDefaultsUtils.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation

enum UserDefaultDataKey: String {
    case balance = "user_balance"
    case transaction = "transaction"
}

class UserDefaultsUtils {
    static let shared = UserDefaultsUtils()
    private let userDefault = UserDefaults.standard
    
    
    func storeData<T>(name: UserDefaultDataKey, value: T) {
        userDefault.setValue(value, forKey: name.rawValue)
        userDefault.synchronize()
    }
    func fetchData(name: UserDefaultDataKey, completion: @escaping (Any?) -> Void) {
        completion(userDefault.object(forKey: name.rawValue))
    }
    func deleteData(name: UserDefaultDataKey) {
        userDefault.removeObject(forKey: name.rawValue)
        userDefault.synchronize()
    }
}
