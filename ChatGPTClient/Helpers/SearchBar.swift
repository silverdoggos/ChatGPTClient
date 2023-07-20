//
//  earchbar.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 23.03.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 28)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                )
            
            if isEditing {
                Button(action:  {
                    isEditing = false
                    text = ""
                    self.hideKeyboard()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                })
                .padding(.trailing, 8)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
        }
    }
}

struct earchbar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search"), isEditing: .constant(false))
    }
}
