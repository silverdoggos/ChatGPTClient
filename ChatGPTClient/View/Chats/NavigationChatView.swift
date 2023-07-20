//
//  NavigationChatView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 30.03.2023.
//

import SwiftUI

struct NavigationChatView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var chatViewModel: ChatViewModel {
        ChatViewModel(conversation: nil, viewContext: viewContext)
    }

    var body: some View {
        NavigationStack {
            ChatView(viewModel: chatViewModel)
                .navigationTitle(Constants.MainTab.chatNavigationTitle)
                .navigationBarTitleDisplayMode(.large)
                .onAppear() {
                    UITabBar.appearance().isTranslucent = false
                    UINavigationBar.appearance().isTranslucent = false
                }
        }
        
    }
}


