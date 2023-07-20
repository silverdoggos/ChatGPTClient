//
//  SettingsHeaderView.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 22.03.2023.
//

import SwiftUI
import Kingfisher

struct SettingsHeaderView: View {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    var body: some View {
        VStack {
            HStack {
                if let profileImage = user.profileImageUrl, let url = URL(string: profileImage) {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .padding(.leading)
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.fullname)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    
                    Text("Available")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .frame(height: 80)
            .background(Color.white)
            .padding(.top)
        }
    }
}


