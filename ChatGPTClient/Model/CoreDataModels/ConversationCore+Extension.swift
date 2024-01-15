//
//  ConversationCore+Extension.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 06.04.2023.
//

import Foundation
import CoreData

extension ConversationCore {
    // MARK: - Properties
    public var id: UUID {
        get { id_ ?? UUID()}
        set { id_ = newValue}
    }
    
    var timestamp: Date {
        get { timestamp_ ?? Date(timeIntervalSince1970: 0)}
        set { timestamp_ = newValue}
    }
    
    var name: String {
        get { name_ ?? ""}
        set { name_ = newValue}
    }
    
    var messages: Set<MessageCore> {
        get { (messagesIn_ as? Set<MessageCore>) ?? [] }
        set { messagesIn_ = newValue as NSSet }
    }
    
    // MARK: - Updates
    static func update(with info: Conversation, context: NSManagedObjectContext) {
        let conversation = self.withId(with: info.id, context: context)
        conversation.name = info.name
        conversation.timestamp = Date.now
        
        do {
            try context.save()
        } catch(let error) {
            debugPrint("Coudn't save conversation with error: \(error)")
        }
        
    }
    
    
    // MARK: - Requests
    static func withId(with id: UUID, context: NSManagedObjectContext) -> ConversationCore {
        let request = fetchRequest(NSPredicate(format: "id_ == %@", id.uuidString))
        let conversations = (try? context.fetch(request)) ?? []
        
        if let conversation = conversations.first {
            return conversation
        } else {
            let conversation = ConversationCore(context: context)
            conversation.id = id
            return conversation
        }
    }
    
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<ConversationCore> {
        let request = NSFetchRequest<ConversationCore>(entityName: "ConversationCore")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp_", ascending: false)]
        request.predicate = predicate
        return request
    }
    
    static func delete(at offsets: IndexSet, context: NSManagedObjectContext, for array: [ConversationCore]) {
        for index in offsets {
            context.delete(array[index])
        }
    }
}

extension ConversationCore {
    func makeConversation() -> Conversation {
        var conversation = Conversation(id: self.id, name: self.name)
        var messages = self.messages.map({Message(id: $0.id, role: $0.role, content: $0.content, isBookmarked: $0.isBookmarked, timestamp: $0.timestamp)})
        messages.sort(by: {$0.timestamp.timeIntervalSince1970 < $1.timestamp.timeIntervalSince1970})
        conversation.changeMassages(with: messages)
        return conversation
    }
}
