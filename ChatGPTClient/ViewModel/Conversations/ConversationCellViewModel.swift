//
//  ConversationCellViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation

class ConversationCellViewModel: ObservableObject {
    @Published var message: Message
    
    init(_ message: Message) {
        self.message = message
    }
}
