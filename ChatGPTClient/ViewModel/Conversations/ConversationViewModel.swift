//
//  ConversationViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation

class ConversationViewModel: ObservableObject {
    @Published var recetMessages = [Message]()
    
    init() {
    }
    
//    func fetchRecentMessages() {
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//
//        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp", descending: true)
//
//        query.getDocuments {snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//
//            self.recetMessages = documents.compactMap({ try? $0.data(as: Message.self) })
//        }
//    }
}
