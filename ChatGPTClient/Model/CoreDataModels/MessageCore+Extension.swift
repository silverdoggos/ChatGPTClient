//
//  MessageCore+Extension.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 06.04.2023.
//

import Foundation
import CoreData

extension MessageCore {
    // MARK: - Properties
    public var id: UUID {
        get { id_ ?? UUID()}
        set { id_ = newValue}
    }
    
    var timestamp: Date {
        get { timestamp_ ?? Date(timeIntervalSince1970: 0)}
        set { timestamp_ = newValue}
    }
    
    var role: ChatRoles {
        get { ChatRoles(rawValue: role_ ?? "") ?? .system}
        set { role_ = newValue.rawValue}
    }
    
    var content: String {
        get { content_ ?? ""}
        set { content_ = newValue}
    }
    
    var isBookmarked: Bool {
        get { isBookmarked_}
        set { isBookmarked_ = newValue}
    }
    
    var conversation: ConversationCore? {
        get { conversationFrom_ }
        set { conversationFrom_ = newValue }
    }
    
    // MARK: - Updates
    static func set(with info: Message, to convarsation: Conversation, context: NSManagedObjectContext) {
        guard !isAlreadyExist(with: info.id, context: context) else { return }
        
        let message = MessageCore(context: context)
        message.id = info.id
        message.timestamp = info.timestamp
        message.role = info.role ?? .system
        message.content = info.content ?? ""
        message.isBookmarked = info.isBookmarked
        message.conversationFrom_ = ConversationCore.withId(with: convarsation.id, context: context)
        
        do {
            try context.save()
        } catch(let error) {
            debugPrint("Coudn't save message with error: \(error)")
        }
    }
    
    static func isAlreadyExist(with id: UUID, context: NSManagedObjectContext) -> Bool {
        let request = fetchRequest(NSPredicate(format: "id_ == %@", id.uuidString))
        let messages = (try? context.fetch(request)) ?? []
        
        if let message = messages.first {
            return true
        } else {
            return false
        }
    }
    
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<MessageCore> {
        let request = NSFetchRequest<MessageCore>(entityName: "MessageCore")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp_", ascending: false)]
        request.predicate = predicate
        return request
    }
}
