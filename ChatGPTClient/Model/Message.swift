//
//  Message.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 25.03.2023.
//

import CoreData

enum ChatRoles: String, Codable {
    case user
    case assistant
    case system
}

fileprivate enum CodingKeys: String, CodingKey {
    case role, content
}


struct Message: Codable, Identifiable {
    let id: UUID
    let role: ChatRoles
    let content: String
    var isBookmarked = false
    let timestamp: Date
    
    init(id: UUID = UUID(), role: ChatRoles, content: String, isBookmarked: Bool = false, timestamp: Date = Date.now) {
        self.id = id
        self.role = role
        self.content = content
        self.timestamp = timestamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        role = try container.decode(ChatRoles.self, forKey: .role)
        content = try container.decode(String.self, forKey: .content)
        timestamp = Date.now
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try container.encode(role, forKey: .role)
        try container.encode(content, forKey: .content)
    }

    mutating func changeBookmark() {
        isBookmarked.toggle()
    }
}
