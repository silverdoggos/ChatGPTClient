//
//  ServerError.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation

struct ServerError: Error {
    
    // MARK: - Public variables
    
    let text: String
    var localizedDescription: String {
        text
    }
    
    // MARK: - Life cycle
    init(text: String) {
        self.text = text
    }
}
