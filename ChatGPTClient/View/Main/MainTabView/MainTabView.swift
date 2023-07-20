//
//  MainTabView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 22.03.2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationChatView()
                .tabItem {Image(systemName: "bubble.left") }
                .tag(0)
            
            ConversationView()
                .tabItem {Image(systemName: "folder.fill") }
                .tag(1)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
