//
//  Conversation.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 29.03.2023.
//

import CoreData

struct Conversation: Identifiable, Decodable {
    var id: UUID
    var name: String
    var messages: [Message]
    
    init(id: UUID = UUID(), name: String, messages: [Message] = []) {
        self.id = id
        self.name = name
        self.messages = messages
    }
    
    mutating func changeName(with name: String) {
        self.name = name
    }
    
    mutating func changeMassages(with messages: [Message]) {
        self.messages = messages
    }
}
