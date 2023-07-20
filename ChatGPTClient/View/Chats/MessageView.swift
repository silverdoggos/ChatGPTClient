//
//  MessageView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 25.03.2023.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: MessageViewModel
    
    var body: some View {
        
        HStack {
            if viewModel.message.role == .user {
                Spacer()
                
                Text(viewModel.message.content ?? "")
                    .textSelection(.enabled)
                    .padding(12)
                    .background(Color(.blue))
                    .font(.system(size:15))
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading, 100)
            } else if viewModel.message.role == .assistant {
                VStack(alignment: .leading) {
                    Text(viewModel.message.content ?? "")
                        .textSelection(.enabled)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .font(.system(size:15))
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .lineLimit(nil)                        
                    
                    HStack(spacing: 10) {
                        Button(action: {
                            viewModel.copyMassage()
                        },
                               label: {
                            Image(systemName: "doc.on.doc.fill")
                        })

                        Button(action: {
                            viewModel.addToBookmark()
                        },
                               label: {
                            Image(systemName: viewModel.message.isBookmarked ? "bookmark.fill" : "bookmark")
                        })

                        Spacer()
                    }
                    .padding(.leading, 12)
                }
                .padding(.horizontal, 10)
                
            } else {
                Spacer()
                
                Text(viewModel.message.content ?? "")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .font(.system(size:14))
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(viewModel: MessageViewModel(Message(role: .assistant, content: "interesting and informative about the history of the Roman Empire.\n\nThe Roman Empire was one of the largest and most powerful empires in the ancient world, spanning from the 8th century BC to the 5th century AD. At its height, it controlled a vast territory that stretched from modern-day Spain to the Middle East and North Africa. \n\nThe Roman Empire was known for its remarkable architectural achievements, including the construction of iconic structures such as the Colosseum and the Pantheon. The empire was also responsible for many important technological innovations, such as the aqueducts that allowed for the efficient transport of water over long distances.\n\nOne of the most interesting aspects of Roman history is the way in which the empire transformed over time. Originally a republic with a system of elected officials, it eventually became a monarchy under the rule of emperors. The empire also went through periods of growth and decline, with some periods marked by prosperity and stability, while others were characterized by conflict and turmoil. The eventual collapse of the Roman Empire in the 5th century AD marked the end of an era in world history.")))
    }
}
