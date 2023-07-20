//
//  SettingsViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 22.03.2023.
//

import SwiftUI

enum SettingsCellViewModel: Int, CaseIterable {
    case account
    case notifications
    case savedMessages
    
    var titile: String {
        switch self {
        case .account: return "Account"
        case .notifications: return "Notifications"
        case .savedMessages: return "Saved Messages"
        }
    }
    
    var imageName: String {
        switch self {
        case .account: return "key.fill"
        case .notifications: return "bell.badge.fill"
        case .savedMessages: return "star.fill"
        }
    }
    
    var imageBackgroundColor: Color {
        switch self {
        case .account: return .blue
        case .notifications: return .red
        case .savedMessages: return .cyan
        }
    }
}
