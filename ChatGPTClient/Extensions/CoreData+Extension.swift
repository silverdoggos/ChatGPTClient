//
//  CoreData+Extansion.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 03.04.2023.
//


import CoreData

extension NSManagedObjectContext {

    func saveContext() {
        if self.hasChanges {
            do{
                Task(priority: .background) {
                    try self.save()
                }
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}


//extension ConversationCore {
//    // MARK: - Request
//    static func fetch()-> NSFetchRequest<ConversationCore>{
//        let request = NSFetchRequest<ConversationCore>(entityName: "ConversationCore")
//
//        request.predicate = NSPredicate.all
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \ConversationCore.timestamp,
//                                                    ascending: true)]
//        return request
//    }
//
//    //----------- Intents --------------
//    static func delete (at offsets: IndexSet, for items:[ConversationCore]) {
//        if let first = items.first, let context = first.managedObjectContext {
//            offsets.map { items[$0] }.forEach(context.delete)
//            context.saveContext()
//        }
//    }
//}
