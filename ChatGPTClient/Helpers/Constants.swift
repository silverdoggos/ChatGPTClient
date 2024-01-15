//
//  Constants.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 26.03.2023.
//

let HOST_API = "https://api.openai.com/v1"
let OPENAI_TOKEN = "open_ai_token"

struct Constants {
    static let errorWarningText = "Something went wrong. Try again later :("
    static let saveText = "Save"
    static let cancelText = "Cancel"
    
    
    struct MainTab {
        static let chatNavigationTitle = "Ask me... 😶‍🌫️"
        static let savedConversationNavigationTitle = "Saved Conversations"
    }
    
    struct Chat {
        static let errorMessage = "Sorry 😔 we couldn't proccess your message\n Try Again!"
        
        static let alertTitle = "Enter new conversation name"
        static let alertMessageText = "It's optional. You can just save it by tapping Save or go back Cancel"
        static let alerPlaceHolderTitle = "Conversation name"

    }
}
