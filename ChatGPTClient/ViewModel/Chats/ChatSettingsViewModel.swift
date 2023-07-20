//
//  ChatSettingsViewModel.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 30.03.2023.
//

import SwiftUI

enum SettingsKeys {
    static let temperature = "temperature"
    static let timeout = "request_timeout"
}

final class ChatSettingViewModel {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
    }
    
    var requestTimeout: Int {
        get {
            if defaults.bool(forKey: SettingsKeys.timeout) {
                return defaults.integer(forKey: SettingsKeys.timeout)
            }
            return 60
        }
        set { defaults.set(newValue, forKey: SettingsKeys.timeout) }
    }
    
    
    var temperatureLevel: Double {
        set { defaults.set(newValue / 10, forKey: SettingsKeys.temperature) }
        get {
            
            if let _ = defaults.value(forKey: SettingsKeys.temperature){
                return defaults.double(forKey: SettingsKeys.temperature) * 10
            }
            
            return 10
        }
    }
}
