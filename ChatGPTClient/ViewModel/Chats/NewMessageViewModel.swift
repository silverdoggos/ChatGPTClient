//
//  NewMessageViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 26.03.2023.
//

import Foundation

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
    }
}

