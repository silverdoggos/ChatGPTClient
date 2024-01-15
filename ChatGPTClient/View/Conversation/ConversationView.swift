//
//  ConversationView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 22.03.2023.
//

import SwiftUI

struct ConversationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @FetchRequest(fetchRequest: ConversationCore.fetchRequest(.all))
    private var conversations: FetchedResults<ConversationCore>
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedConversation: ConversationCore?
    private var chatViewModel: ChatViewModel?
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedConversation)  {
                ForEach(conversations, id: \.id) { conversation in
                    
                    NavigationLink(value: conversation) {
                        Text("\(conversation.name)")
                    }
                    .padding(.vertical, 10)
                }
                .onDelete(perform: deleteItems)
            }
            .padding(.top, 10)
            .navigationTitle("Saved conversations")
            .navigationBarTitleDisplayMode(.inline)

        } detail: {
            if let coversation = selectedConversation?.makeConversation() {
                ChatView(viewModel: ChatViewModel(conversation: coversation, viewContext: viewContext, chatMode: .saved))
                    .navigationTitle(selectedConversation?.name ?? "")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Select a conversation")
            }
            
        }
        .onAppear() {
            UINavigationBar.appearance().isTranslucent = true
        }
        .navigationSplitViewStyle(.balanced)
    }
            
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            ConversationCore.delete(at: offsets, context: viewContext, for: Array(conversations))
            refreshDetailViewIfNeeded(with: offsets)
        }
    }
    
    private func refreshDetailViewIfNeeded(with offsets: IndexSet) {
        offsets.forEach({
            if conversations[$0] == selectedConversation {
                selectedConversation = nil
            }
        })
    }
}
