//
//  PersistenceController.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 03.04.2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    // Convenience
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ChatGPTClient")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
