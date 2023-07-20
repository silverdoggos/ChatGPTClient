//
//  CustomTextField.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 21.03.2023.
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let placeholderText:String
    @Binding var text: String
    let isSecureField: Bool
    
    
    // override init just to set isSecureField property a default value
    init(imageName: String, placeholderText: String, text: Binding<String>, isSecureField: Bool = false) {
        self.imageName = imageName
        self.placeholderText = placeholderText
        self._text = text
        self.isSecureField = isSecureField
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                        .textInputAutocapitalization(.never)
                }
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}
