//
//  BalanceInteractor.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import CoreData
class BalanceInteractor {
    static let shared = BalanceInteractor(taskContext: BalanceProvider.shared.newTaskContext())
    private let entityName = "BalanceEntity"
    private let taskContext: NSManagedObjectContext?
    init(taskContext: NSManagedObjectContext?) {
        self.taskContext = taskContext
    }
}

extension BalanceInteractor {
    func getBalance(completion: @escaping (BalanceModel?) -> Void) {
        taskContext?.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.fetchLimit = 1
            do {
                if let result = try self.taskContext?.fetch(fetchRequest).first {
                    let item = BalanceModel(balance: result.value(forKey: "balance") as? Double)
                    print("BalanceInteractor - get Balance \(item)")

                    completion(item)
                } else {
                    completion(nil)                    
                }
            } catch let err {
                completion(nil)
                print("Error - BalanceProvider: \(err)")
            }
        }
    }
    
    func addBalance(_ amount: Double, completion: @escaping (BalanceModel?) -> Void) {
        guard let taskContext = taskContext else {return}
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: taskContext) {
                let balance = NSManagedObject(entity: entity, insertInto: taskContext)
                getBalance { bal in
                    DispatchQueue.main.async {
                        balance.setValue((bal?.balance ?? 0) + amount, forKeyPath: "balance")
                        print("BalanceInteractor - Add Balance \(String(describing: balance.value(forKeyPath: "balance")))")
                        //saving...
                        do {
                            try taskContext.save()
                            completion(BalanceModel(balance: balance.value(forKeyPath: "balance") as? Double))
                        } catch let err {
                            completion(nil)
                            print("Error - BalanceProvider: \(err)")
                        }
                    }
                }
            }
        }
    }
    
    func updateBalance(_ amount: Double, isMinus: Bool = false, completion: @escaping (BalanceModel?) -> Void) {
        guard let taskContext = taskContext else {return}
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.fetchLimit = 1
            if let result = try? taskContext.fetch(fetchRequest), let balance = result.first as? BalanceEntity {
                DispatchQueue.main.async {
                    
                    let oldBal = balance.balance
                    var newAmount = 0.0
                    if isMinus {
                        newAmount = (oldBal) - amount
                    } else {
                        newAmount = amount + (oldBal)
                    }
                    print(newAmount)
                    balance.setValue(newAmount, forKeyPath: "balance")
                    do {
                        try taskContext.save()
                        completion(BalanceModel(balance: balance.balance))
                    } catch let err {
                        completion(nil)
                        print("Error - BalanceProvider: \(err)")
                    }
                    print("BalanceInteractor - Update Balance \(String(describing: oldBal))")
                }
            }
        }
    }
}
