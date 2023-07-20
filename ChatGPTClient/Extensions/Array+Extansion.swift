//
//  Array+Extansion.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 30.03.2023.
//

import Foundation

extension Array<Message> {
    func prepareToRequest() -> [[String: String]] {
        var messagesArray: [[String: String]] = []
        for message in self.filter({$0.role != .system}) {
            if let role = message.role?.rawValue, let text = message.content {
                messagesArray.append(["role": role, "content": text])
            }
        }
        return messagesArray
    }
}
