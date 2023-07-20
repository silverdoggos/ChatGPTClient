//
//  NewMessageView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 23.03.2023.
//

import SwiftUI

struct NewMessageView: View {
    @ObservedObject var viewModel = NewMessageViewModel()
    @Binding var showChatView: Bool
    @State private var searchText: String = ""
    @State private var isEditing: Bool = false
    @Binding var user: User?
    @Environment(\.dismiss) private var dismiss;
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $isEditing)
                .onTapGesture {
                    isEditing.toggle()
                }
                .padding()
            VStack(alignment: .leading) {
                ForEach(viewModel.users, id: \.id) { user in
                    Button(action: {
                        showChatView.toggle()
                        self.user = user
                        dismiss()
                    }, label: {
                        UserCell(user: user)
                    })
                    
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(showChatView: .constant(true), user: .constant(MOCK_USERS))
    }
}
