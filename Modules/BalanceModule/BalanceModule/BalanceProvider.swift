//
//  BalanceProvider.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import CoreData

class BalanceProvider {
    static let shared = BalanceProvider()
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BalanceDataModel")
        container.loadPersistentStores { _, err in
            guard err == nil else {
                fatalError("Unresolved Error: \(String(describing: err))")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    
    
    
    func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    
}
