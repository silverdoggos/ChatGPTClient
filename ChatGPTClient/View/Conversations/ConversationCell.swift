//
//  UserCell.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 23.03.2023.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    @ObservedObject var viewModel: ConversationCellViewModel
    
    var body: some View {
//            NavigationLink(destination: ChatView(user: user),
//                           label: {
                VStack {
                    HStack {
                        
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
//                            Text(viewModel.conversation.name)
//                                .font(.system(size: 14, weight: .semibold))
//
//                            Text(viewModel.message.text)
//                                .font(.system(size: 15))
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    
                    Divider()
                        .foregroundColor(.gray)
                }
                .padding(.top)
//            })
        }
}
