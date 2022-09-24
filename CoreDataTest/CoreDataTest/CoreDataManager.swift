//
//  CoreDataManager.swift
//  CoreDataTest
//
//  Created by Tomáš Valášek on 24.09.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    private var persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataTest")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to initialize \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
