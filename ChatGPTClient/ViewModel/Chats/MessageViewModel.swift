//
//  MessageViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation
import SwiftUI

class MessageViewModel: ObservableObject {
    @Published var message: Message
    
    init(_ message: Message) {
        self.message = message
    }
    
    func copyMassage() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = message.content
    }
    
    func addToBookmark() {
        message.changeBookmark()
        print(message.id)
    }
}
