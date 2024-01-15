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
            messagesArray.append(["role": message.role.rawValue, "content": message.content])
        }
        return messagesArray
    }
}
