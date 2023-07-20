//
//  UserCell.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 23.03.2023.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
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
                    Text("@\(user.username)")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(user.fullname)
                        .font(.system(size: 15))
                }
                
                Spacer()
            }
            .foregroundColor(.black)
        }
        .padding([.top, .horizontal ])
    }
}
