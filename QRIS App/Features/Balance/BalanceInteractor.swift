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
    internal func getBalance(completion: @escaping (BalanceModel?) -> Void) {
        taskContext?.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.fetchLimit = 1
            do {
                if let result = try self.taskContext?.fetch(fetchRequest).first {
                    let item = BalanceModel(balance: result.value(forKey: "balance") as? Double)
                    completion(item)
                }
            } catch let err {
                print("Error - BalanceProvider: \(err)")
            }
        }
    }
    
    internal func addBalance(_ amount: Double) {
        guard let taskContext = taskContext else {return}
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            
            if let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: taskContext) {
                let balance = NSManagedObject(entity: entity, insertInto: taskContext)
                balance.setValue(amount, forKeyPath: "balance")
                
                //saving...
                do {
                    try taskContext.save()
                } catch let err {
                    print("Error - BalanceProvider: \(err)")
                }
            }
        }
    }
}
