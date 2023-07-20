//
//  ChatViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 25.03.2023.
//

import Foundation
import CoreData
import SwiftUI

protocol ChatViewModelProtocol: ObservableObject {
    func sendMessage(_ messageText: String)
    func saveConversation(with name: String)
    func updateSettings()
    func resetConversation()
}

enum ChatViewMode {
    case newOne
    case saved
}

class ChatViewModel: ChatViewModelProtocol {
    var viewContext: NSManagedObjectContext
    var mode: ChatViewMode
    @Published var messages = [Message]()
    @Published var error: Error?
    let customInputViewModel = CustomInputViewModel()
    var conversation: Conversation
    let apiClient = CoreApiClient(host: HOST_API, timeout: 60)
    private var taskFetch: Task<Void, Never>?
    private var temprature: Double?
    
    
    
    init(conversation: Conversation?, viewContext: NSManagedObjectContext, chatMode: ChatViewMode = .newOne) {
        self.conversation = conversation ?? Conversation(name: "", messages: [])
        self.viewContext = viewContext
        self.mode = chatMode
        displayMessages()
        updateSettings()
    }
    
    deinit {
        guard messages.count != conversation.messages.count else { return }
        saveConversation(with: "")
    }
    
    private func displayMessages() {
        self.messages = conversation.messages
    }
    
// MARK: - Actions
    func saveConversation(with name: String) {
        if conversation.name.isEmpty {
            let newName = name.isEmpty ? (messages.first?.content ?? "\(conversation.id)") : name
            conversation.changeName(with: newName)
        }
        conversation.changeMassages(with: messages)
        
        ConversationCore.update(with: conversation, context: viewContext)
        
        messages.forEach({
            MessageCore.set(with: $0, to: self.conversation, context: self.viewContext)
        })
    }
    
    func resetConversation() {
        taskFetch?.cancel()
        self.messages = []
        self.conversation = Conversation(name: "", messages: [])
    }
    
    func sendMessage(_ messageText: String)  {
        messages.append(Message(role: .user, content: messageText))
        customInputViewModel.isLoading = true
        
        taskFetch = Task(priority: .high) {
            let messages = await getAnswerFromGPT(messageText)
            guard !Task.isCancelled else {
                await handleNewMessageInMainThread(with: nil, withoutMessage: true)
                return
            }
            await handleNewMessageInMainThread(with: messages)
        }
    }
}
// MARK: - Networking
extension ChatViewModel {
    @MainActor
    private func handleNewMessageInMainThread(with message: [Message]?, withoutMessage: Bool = false)  {
            if let newMessage = message {
                self.messages.append(contentsOf: newMessage)
            } else if !withoutMessage {
                self.messages.append(Message(role: .system, content: Constants.Chat.errorMessage))
            }
            self.customInputViewModel.isLoading = false
    }
    
    private func getAnswerFromGPT(_ messageText: String) async -> [Message]? {
        
        var headers: [String: String] = [:]
        headers.updateValue("application/json", forKey: "Content-Type")
        headers.updateValue("Bearer \(OPENAI_TOKEN)", forKey: "Authorization")
        
        let payload: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": self.messages.prepareToRequest(),
            "temperature": self.temprature ?? 1
        ]
        
        let requestData: RequestData = RequestData(endpoint: "chat/completions", method: .POST, headers: headers)
        
        if let data = try? await apiClient.send(requestData, payload: payload) {
            let chatResponse = try? JSONDecoder().decode(ChatResponse.self, from: data )
            var newMessages = [Message]()
            chatResponse?.choices?.forEach {
                if let message = $0.message, let content = message.content, !content.isEmpty {
                    newMessages.append(message)
                }
            }
            
            return newMessages.isEmpty ? nil : newMessages
        }
        return nil
    }
}

// MARK: - Settings
extension ChatViewModel {
    func updateSettings() {
        let defaults: UserDefaults = .standard
        
        if defaults.bool(forKey: SettingsKeys.temperature) {
            self.temprature = defaults.double(forKey: SettingsKeys.temperature)
        }
        
        if defaults.bool(forKey: SettingsKeys.timeout) {
            apiClient.setTimeout(TimeInterval(defaults.integer(forKey: SettingsKeys.timeout)))
        }
    }
}
