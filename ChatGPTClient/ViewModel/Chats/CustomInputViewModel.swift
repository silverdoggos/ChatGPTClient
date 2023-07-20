//
//  CustomInputViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 30.03.2023.
//

import Foundation

class CustomInputViewModel: ObservableObject {
    @Published var isLoading = false
    
    func set(isLoading: Bool) {
        self.isLoading = true
    }
}
