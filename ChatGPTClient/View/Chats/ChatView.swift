//
//  ChatsView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 22.03.2023.
//

import SwiftUI
import Combine

struct ChatView: View {
    @State private var messageText = ""
    @State private var saveConversationAlert = false
    @State private var conversationName = ""
    @State private var settingPageSheet = false
    @State private var keyboardHeight: CGFloat = 0

    @ObservedObject var viewModel: ChatViewModel
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            messageScrollView
            
            CustomInputView(text: $messageText, viewModel: viewModel.customInputViewModel, action:
                                sendMessage)
        }
        .padding(.bottom)
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    settingPageSheet = true
                }, label: {
                    Image(systemName: "gear")
                })
            }
            
            if viewModel.mode == .newOne {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.resetConversation()
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                }
                
                
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.saveConversationAlert = true
                    }, label: {
                        Image(systemName: "folder.fill.badge.plus")
                    })
                }
            }
        }
        
        .alert(Constants.Chat.alertTitle, isPresented: $saveConversationAlert, actions: ({
            TextField(Constants.Chat.alerPlaceHolderTitle, text: $conversationName)
            Button(Constants.saveText, action: saveConversation)
            Button(Constants.cancelText, role: .cancel) { }
        }), message: ({
            Text(Constants.Chat.alertMessageText)
        }))
        
        .sheet(isPresented: $settingPageSheet, onDismiss: updateViewModel, content: {
            ChatSettingSheet()
                .presentationDetents([.height(300)])
                .cornerRadius(10)
        })
        
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
    
    private var messageScrollView: some View {
        ScrollViewReader { reader in
            ScrollView(.vertical) {
                ZStack {
                    Color(.systemBackground)
                    
                    LazyVStack(alignment: .leading, spacing: 12) {
                        
                        ForEach(viewModel.messages) { message in
                            MessageView(viewModel: MessageViewModel(message))
                        }
                    }
                }
            }
            
            .onChange(of: keyboardHeight) { id in
                guard let id = viewModel.messages.last?.id else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation() {
                        reader.scrollTo(id, anchor: .bottom)
                    }
                }
            }
            .onChange(of: viewModel.messages.count) { id in
                guard let id = viewModel.messages.last?.id else { return }

                withAnimation() {
                    reader.scrollTo(id)
                }
            }
            
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    private func sendMessage() {
        viewModel.sendMessage(messageText)
        messageText = ""
    }
    
    private func saveConversation() {
        viewModel.saveConversation(with: conversationName)
    }
    
    private func updateViewModel() {
        viewModel.updateSettings()
    }
}
