//
//  ChatResponse.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 29.03.2023.
//

import Foundation

struct ChatResponse: Codable {
    let id: String?
    let object: String?
    let created: Int?
    let choices: [Choice]?
}

