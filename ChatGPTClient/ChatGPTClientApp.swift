//
//  ChatGPTClientApp.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 21.03.2023.
//

import SwiftUI

@main
struct ChatGPTClientApp: App {

    init() {
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, PersistenceController.shared.viewContext)
        }
    }
}
