//
//  Choice.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 29.03.2023.
//

import Foundation

struct Choice: Codable {
    let index: Int?
    let message: Message?
    let finish_reason: String?
}
