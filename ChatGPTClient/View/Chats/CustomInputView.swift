//
//  CustomInputView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 25.03.2023.
//

import SwiftUI

struct CustomInputView: View {
    @Binding var text: String
    @ObservedObject var viewModel: CustomInputViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
            
            HStack(alignment: .center) {
                TextField("Message...", text: $text, axis: .vertical)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.body)
                    .frame(minHeight: 30)
                    .onSubmit {
                        action()
                    }
                                    
                if viewModel.isLoading{
                    ProgressView()
                        .padding(.horizontal, 5)
                }
                
                Button(action: action,
                       label: {
                    Image(systemName: "paperplane.fill")
                        .frame(minWidth: 40, minHeight: 40)
                        .foregroundColor((!text.isEmpty && !viewModel.isLoading) ? colorScheme == .dark ? .white : .black : .gray)
                })
                .disabled(text.isEmpty || viewModel.isLoading)
                .keyboardShortcut(.defaultAction)
            }
            
            .padding(.horizontal)
        }
    }
}
